# GetX Service Locator Pattern

You are a GetX service management expert specializing in centralized service initialization and dependency injection patterns.

## Overview

The ServiceLocator pattern in GetX provides centralized initialization and lifecycle management for global services using `Get.put()` with the `permanent: true` flag. This ensures services persist throughout the app lifecycle and are accessible anywhere via dependency injection.

## ServiceLocator Architecture

### Core Structure

```dart
class ServiceLocator {
  static Future<void> init() async {
    // Step 1: Initialize Firebase FIRST (other services may depend on it)
    final firebaseService = Get.put(FirebaseService(), permanent: true);
    await firebaseService.onInit();

    // Step 2: Register core services
    Get.put(ApiService(), permanent: true);
    Get.put(SubscribeService(), permanent: true);
    Get.put(AnalyticsService(), permanent: true);

    // Step 3: Register and initialize controllers with async setup
    final localeController = Get.put(LocaleController(), permanent: true);
    await localeController.loadSavedLocale();

    // Step 4: Trigger onInit() for services that need it
    await Get.find<SubscribeService>().onInit();
    Get.find<ApiService>().onInit();
  }
}
```

### App Entry Point Integration

```dart
// main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize all services (including Firebase)
  await ServiceLocator.init();

  runApp(const SovaApp());
}
```

## Service Implementation Patterns

### 1. Basic GetxService Pattern

```dart
class ApiService extends GetxService {
  // Singleton accessor for convenience
  static ApiService get to => Get.find();

  // Lazy initialization of dependencies
  Dio? _dioInstance;
  Dio get _dio {
    _dioInstance ??= NetworkConfig.createDio(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 30),
    );
    return _dioInstance!;
  }

  @override
  void onInit() {
    super.onInit();
    print('🌐 ApiService: Initialized');
    // Initialize Dio on first access via getter
  }

  // Service methods...
  Future<String> getInspiration({String? prompt}) async {
    // Implementation...
  }
}
```

**Key Benefits:**
- ✅ **Extends GetxService**: Provides proper lifecycle management
- ✅ **Singleton Accessor**: `static get to` for convenient access
- ✅ **Lazy Initialization**: Resources created only when needed
- ✅ **onInit() Hook**: For initialization logic

### 2. Service with Reactive State

```dart
class SubscribeService extends GetxService {
  // Observable states
  final RxBool isLoading = false.obs;
  final RxBool isSubscribed = false.obs;
  final Rx<CustomerInfo?> customerInfo = Rx<CustomerInfo?>(null);
  final RxInt availableCredits = 0.obs;

  // Configuration constants
  static const int defaultFreeCredits = 1;
  static const String _creditsKey = 'user_credits';

  Timer? _delayedLoadTimer;
  bool _initialLoadCompleted = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _initialize();
    await _initializeCredits();
    _scheduleDelayedLoad();
  }

  Future<void> _initialize() async {
    // SDK initialization
    await Purchases.configure(PurchasesConfiguration(apiKey));
  }

  Future<void> _initializeCredits() async {
    final prefs = await SharedPreferences.getInstance();
    final credits = prefs.getInt(_creditsKey) ?? defaultFreeCredits;
    availableCredits.value = credits;
  }

  @override
  void onClose() {
    _delayedLoadTimer?.cancel();
    super.onClose();
  }
}
```

**Key Features:**
- ✅ **Reactive State**: Use `.obs` for reactive variables
- ✅ **Async Initialization**: Handle async setup in `onInit()`
- ✅ **Resource Cleanup**: Dispose timers/subscriptions in `onClose()`
- ✅ **Persistent Data**: Integration with SharedPreferences

### 3. Service with Cross-Service Dependencies

```dart
class NotificationService extends GetxService {
  static NotificationService get to => Get.find();

  // Dependency injection - find other services
  ApiService get _apiService => Get.find<ApiService>();

  // Reactive state
  final RxBool hasUnreadNotifications = false.obs;
  final RxList<Notification> notifications = <Notification>[].obs;

  Timer? _pollingTimer;

  @override
  void onInit() {
    super.onInit();
    print('🔔 NotificationService: Service initialized');
    _startPolling();
  }

  Future<void> fetchNotifications() async {
    try {
      // Use injected ApiService
      final response = await _apiService.getNotifications();

      notifications.value = response.map((e) => Notification.fromJson(e)).toList();
      hasUnreadNotifications.value = notifications.any((n) => !n.isRead);
    } catch (error) {
      print('Error fetching notifications: $error');
    }
  }

  Future<void> markAsRead(String notificationId) async {
    // Cross-service communication
    await _apiService.markNotificationAsRead(notificationId);

    final notification = notifications.firstWhere((n) => n.id == notificationId);
    notification.isRead = true;
    notifications.refresh();
    hasUnreadNotifications.value = notifications.any((n) => !n.isRead);
  }

  void _startPolling() {
    _pollingTimer = Timer.periodic(Duration(minutes: 5), (_) {
      fetchNotifications();
    });
  }

  @override
  void onClose() {
    _pollingTimer?.cancel();
    super.onClose();
  }
}
```

**Dependency Injection Pattern:**
- ✅ **Getter Injection**: `Get.find<Service>()` in getters for lazy access
- ✅ **Local Variables**: `Get.find<Service>()` in methods for one-time use
- ✅ **Avoid Constructor Injection**: Services registered in ServiceLocator

### 4. Foundation Service (Firebase, Database)

Foundation services are critical dependencies that MUST be initialized first, before other services.

```dart
/// Firebase initialization service
/// Must be initialized FIRST in ServiceLocator - other services may depend on Firebase
class FirebaseService extends GetxService {
  static FirebaseService get to => Get.find();

  bool _initialized = false;
  bool get isInitialized => _initialized;

  /// Initialize Firebase - called from ServiceLocator.init()
  @override
  Future<void> onInit() async {
    super.onInit();
    await _initialize();
  }

  Future<void> _initialize() async {
    if (_initialized) return;

    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      _initialized = true;

      if (kDebugMode) {
        print('🔥 FirebaseService: Initialized successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ FirebaseService: Initialization error: $e');
        print('⚠️ FirebaseService: Using demo config');
      }
      // Mark as initialized even on failure for graceful degradation
      _initialized = true;
    }
  }
}
```

**Why Initialize Firebase in ServiceLocator?**

```dart
// ❌ WRONG: Firebase outside ServiceLocator
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(); // Separate initialization
  await ServiceLocator.init();

  runApp(const SovaApp());
}

// ✅ CORRECT: Firebase inside ServiceLocator
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ServiceLocator.init(); // Firebase initialized first, then other services

  runApp(const SovaApp());
}

class ServiceLocator {
  static Future<void> init() async {
    // Step 1: Initialize Firebase FIRST
    final firebaseService = Get.put(FirebaseService(), permanent: true);
    await firebaseService.onInit();

    // Step 2: Now other services can safely use Firebase
    Get.put(AnalyticsService(), permanent: true); // May use FirebaseAnalytics
    Get.put(AuthService(), permanent: true);      // May use FirebaseAuth
    Get.put(StorageService(), permanent: true);   // May use FirebaseStorage
  }
}
```

**Benefits of This Approach:**
- ✅ **Centralized Management**: All service initialization in one place
- ✅ **Dependency Order**: Firebase guaranteed to be ready before dependent services
- ✅ **Consistent Pattern**: Firebase is a service like any other
- ✅ **Testable**: Easy to mock FirebaseService in tests
- ✅ **Accessible**: `FirebaseService.to.isInitialized` available anywhere
- ✅ **Graceful Degradation**: Handles initialization failures elegantly

## Service Registration Best Practices

### 1. Registration Order Matters

**Critical Rule**: Foundation services (Firebase, Database) MUST be initialized FIRST.

```dart
static Future<void> init() async {
  // Step 1: Initialize foundation services FIRST
  final firebaseService = Get.put(FirebaseService(), permanent: true);
  await firebaseService.onInit();

  // Step 2: Register independent services
  Get.put(ApiService(), permanent: true);

  // Step 3: Register services with dependencies
  Get.put(NotificationService(), permanent: true); // Depends on ApiService
  Get.put(AnalyticsService(), permanent: true);    // May depend on Firebase

  // Step 4: Register controllers with async setup
  final localeController = Get.put(LocaleController(), permanent: true);
  await localeController.loadSavedLocale();

  // Step 5: Manually call onInit() for services that need it
  await Get.find<SubscribeService>().onInit();
}
```

**Registration Sequence:**
1. **Foundation Services**: Firebase, Database (MUST be first)
2. **Independent Services**: No dependencies (e.g., ApiService)
3. **Dependent Services**: Services that use other services
4. **Controllers with Async Setup**: Register and await initialization
5. **Manual onInit() Calls**: For services requiring explicit initialization

**Why This Order?**
```dart
// ❌ WRONG: Analytics registered before Firebase
Get.put(AnalyticsService(), permanent: true); // Tries to use FirebaseAnalytics
Get.put(FirebaseService(), permanent: true);  // Firebase not ready yet!

// ✅ CORRECT: Firebase first, then dependent services
final firebaseService = Get.put(FirebaseService(), permanent: true);
await firebaseService.onInit(); // Firebase fully initialized
Get.put(AnalyticsService(), permanent: true); // Can safely use FirebaseAnalytics
```

### 2. Permanent vs Non-Permanent Registration

```dart
// ✅ CORRECT: Permanent services
Get.put(ApiService(), permanent: true);           // Global singleton
Get.put(SubscribeService(), permanent: true);     // Persists entire lifecycle

// ❌ WRONG: Non-permanent for global services
Get.put(ApiService());  // Will be garbage collected when not in use

// ✅ CORRECT: Non-permanent for page controllers
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController()); // Disposed when page closes
    return Scaffold(...);
  }
}
```

**When to Use permanent: true:**
- ✅ Global services (API, Database, Analytics)
- ✅ Services accessed across multiple pages
- ✅ Services with persistent state (SubscribeService)
- ✅ Services with background tasks (NotificationService)

**When NOT to Use permanent: true:**
- ❌ Page-specific controllers
- ❌ Temporary utilities
- ❌ Controllers tied to widget lifecycle

### 3. Service Discovery Pattern

```dart
// Pattern 1: Singleton Accessor (Recommended for frequent access)
class ApiService extends GetxService {
  static ApiService get to => Get.find();
}
// Usage: ApiService.to.uploadImage(file)

// Pattern 2: Direct Find (Recommended for occasional access)
final apiService = Get.find<ApiService>();
// Usage: apiService.uploadImage(file)

// Pattern 3: Getter Injection (Recommended for service dependencies)
class NotificationService extends GetxService {
  ApiService get _apiService => Get.find<ApiService>();
  // Lazy evaluation, only called when needed
}
```

## Service Initialization Timing

### Sequential vs Parallel Initialization

```dart
static Future<void> init() async {
  // Sequential: Services registered in order
  Get.put(ApiService(), permanent: true);
  Get.put(SubscribeService(), permanent: true);

  // Parallel: Async operations can run concurrently
  await Future.wait([
    Get.find<SubscribeService>().onInit(),
    FirebaseService.initialize(),
  ]);

  // Sequential: Dependent initialization
  Get.find<NotificationService>().onInit();
  Get.find<ApiService>().onInit();
}
```

**Best Practices:**
- ✅ Register all services before calling onInit()
- ✅ Use `Future.wait()` for independent async operations
- ✅ Await critical services before app startup
- ✅ Use delayed initialization for non-critical services

## Common Patterns and Anti-Patterns

### ✅ CORRECT Patterns

```dart
// 1. Service with lazy dependency injection
class DataService extends GetxService {
  ApiService get _apiService => Get.find<ApiService>();

  Future<void> syncData() async {
    await _apiService.syncUserData(...);
  }
}

// 2. Service with reactive state
class SubscribeService extends GetxService {
  final RxBool isSubscribed = false.obs;

  Future<void> checkSubscription() async {
    final status = await fetchStatus();
    isSubscribed.value = status;
  }
}

// 3. Service with proper cleanup
class PollingService extends GetxService {
  Timer? _timer;

  @override
  void onInit() {
    _timer = Timer.periodic(Duration(seconds: 5), (_) => poll());
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}

// 4. Widget accessing service
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final subscribeService = Get.find<SubscribeService>();

    return Obx(() => Text(
      subscribeService.isSubscribed.value ? 'Pro' : 'Free'
    ));
  }
}
```

### ❌ INCORRECT Anti-Patterns

```dart
// ❌ WRONG: Constructor injection for services
class DataService extends GetxService {
  final ApiService apiService;
  DataService(this.apiService); // Don't do this
}

// ❌ WRONG: Storing Get.find() result in final field
class DataService extends GetxService {
  final ApiService _apiService = Get.find<ApiService>(); // May fail if not registered yet
}

// ❌ WRONG: Not using permanent flag for global services
Get.put(ApiService()); // Will be disposed prematurely

// ❌ WRONG: Calling onInit() before registration
await SubscribeService().onInit(); // Service not in DI container
Get.put(SubscribeService(), permanent: true);

// ❌ WRONG: Not cleaning up resources
class PollingService extends GetxService {
  Timer? _timer;

  @override
  void onInit() {
    _timer = Timer.periodic(Duration(seconds: 5), (_) => poll());
  }
  // Missing onClose() - timer will leak
}

// ❌ WRONG: Direct service instantiation
final apiService = ApiService(); // Bypass DI container
```

## Testing Services

```dart
void main() {
  setUp(() async {
    // Initialize GetX for testing
    Get.testMode = true;

    // Register mock services
    Get.put<ApiService>(MockApiService(), permanent: true);
    Get.put<SubscribeService>(MockSubscribeService(), permanent: true);
  });

  tearDown(() {
    // Clean up
    Get.reset();
  });

  test('NotificationService fetches notifications successfully', () async {
    final notificationService = Get.put(NotificationService());

    await notificationService.fetchNotifications();

    expect(notificationService.notifications.isNotEmpty, true);
  });
}
```

## Migration Checklist

When copying ServiceLocator pattern to a new project:

- [ ] Create `lib/services/service_locator.dart`
- [ ] Ensure all services extend `GetxService`
- [ ] Add `static T get to => Get.find()` to each service
- [ ] Register services in correct dependency order
- [ ] Use `permanent: true` for global services
- [ ] Call `await ServiceLocator.init()` in `main()`
- [ ] Implement `onInit()` for initialization logic
- [ ] Implement `onClose()` for cleanup (timers, streams)
- [ ] Use `Get.find<Service>()` for dependency injection
- [ ] Use `Obx()` or `GetBuilder()` for reactive UI
- [ ] Add proper error handling in service methods
- [ ] Test service registration and dependency resolution

## Key Principles

1. **Single Responsibility**: Each service handles one domain
2. **Dependency Injection**: Services find dependencies via `Get.find()`
3. **Lazy Initialization**: Resources created on first use
4. **Lifecycle Management**: `onInit()` and `onClose()` hooks
5. **Reactive State**: Use `.obs` for state that triggers UI updates
6. **Permanent Registration**: Use `permanent: true` for global services
7. **Error Handling**: Always handle errors gracefully
8. **Cleanup**: Cancel timers, close streams in `onClose()`

## Advanced Patterns

### Conditional Service Registration

```dart
static Future<void> init() async {
  // Always register core services
  Get.put(ApiService(), permanent: true);

  // Conditionally register platform-specific services
  if (Platform.isIOS) {
    Get.put(AppleHealthService(), permanent: true);
  } else if (Platform.isAndroid) {
    Get.put(GoogleFitService(), permanent: true);
  }

  // Conditionally register based on environment
  if (kDebugMode) {
    Get.put(DebugLogService(), permanent: true);
  }
}
```

### Service Configuration

```dart
class ApiService extends GetxService {
  final String baseUrl;
  final Duration timeout;

  ApiService({
    this.baseUrl = 'https://api.example.com',
    this.timeout = const Duration(seconds: 30),
  });
}

// Register with custom configuration
static Future<void> init() async {
  Get.put(
    ApiService(
      baseUrl: kDebugMode ? 'http://localhost:8787' : 'https://api.prod.com',
      timeout: const Duration(seconds: 60),
    ),
    permanent: true,
  );
}
```

### Service Factory Pattern

```dart
class DatabaseService extends GetxService {
  static Future<DatabaseService> create() async {
    final service = DatabaseService();
    await service._initialize();
    return service;
  }

  Future<void> _initialize() async {
    // Heavy initialization work
    await _openDatabase();
    await _runMigrations();
  }
}

// Register with factory
static Future<void> init() async {
  final dbService = await DatabaseService.create();
  Get.put(dbService, permanent: true);
}
```

## Real-World Examples from Codebase

### Example 1: ApiService with Dio

```dart
class ApiService extends GetxService {
  static ApiService get to => Get.find();

  Dio? _dioInstance;
  Dio get _dio {
    _dioInstance ??= NetworkConfig.createDio(
      baseUrl: 'https://api.example.com',
      connectTimeout: const Duration(seconds: 30),
    );
    return _dioInstance!;
  }

  Future<Map<String, dynamic>> _getHeaders() async {
    final token = await JWTManager().apiKey;
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  Future<String> uploadImage(File imageFile) async {
    final headers = await _getHeaders();
    final imageBytes = await imageFile.readAsBytes();

    final response = await _dio.post(
      '/upload',
      data: imageBytes,
      options: Options(headers: headers),
    );

    return response.data['url'] as String;
  }
}
```

### Example 2: SubscribeService with RevenueCat

```dart
class SubscribeService extends GetxService {
  final RxBool isSubscribed = false.obs;
  final RxInt availableCredits = 0.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _initialize();
    await _initializeCredits();
  }

  Future<void> _initialize() async {
    await Purchases.configure(PurchasesConfiguration(apiKey));
  }

  bool get canUseFeature => isSubscribed.value || availableCredits.value > 0;

  Future<bool> consumeCredit() async {
    if (isSubscribed.value) return true;
    if (availableCredits.value <= 0) return false;

    availableCredits.value--;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('credits', availableCredits.value);

    return true;
  }
}
```

### Example 3: AnalyticsService with Event Tracking

```dart
class AnalyticsService extends GetxService {
  static AnalyticsService get to => Get.find();

  // Track user events across the app
  final RxList<AnalyticsEvent> eventQueue = <AnalyticsEvent>[].obs;
  Timer? _flushTimer;

  @override
  void onInit() {
    super.onInit();
    _startAutoFlush();
  }

  /// Log an event
  void logEvent(String eventName, {Map<String, dynamic>? parameters}) {
    final event = AnalyticsEvent(
      name: eventName,
      parameters: parameters,
      timestamp: DateTime.now(),
    );

    eventQueue.add(event);
    print('📊 Analytics: Event logged - $eventName');

    // Auto-flush if queue is large
    if (eventQueue.length >= 10) {
      _flushEvents();
    }
  }

  /// Log screen view
  void logScreenView(String screenName) {
    logEvent('screen_view', parameters: {'screen_name': screenName});
  }

  /// Start auto-flush timer (flush every 30 seconds)
  void _startAutoFlush() {
    _flushTimer = Timer.periodic(Duration(seconds: 30), (_) {
      if (eventQueue.isNotEmpty) {
        _flushEvents();
      }
    });
  }

  /// Flush events to analytics backend
  Future<void> _flushEvents() async {
    if (eventQueue.isEmpty) return;

    try {
      final events = List<AnalyticsEvent>.from(eventQueue);
      eventQueue.clear();

      // Send to analytics service (Firebase, Mixpanel, etc.)
      await _sendToBackend(events);
      print('📊 Analytics: Flushed ${events.length} events');
    } catch (e) {
      print('❌ Analytics: Failed to flush events - $e');
    }
  }

  Future<void> _sendToBackend(List<AnalyticsEvent> events) async {
    // Implementation depends on your analytics provider
    // Firebase: FirebaseAnalytics.instance.logEvent(...)
    // Mixpanel: Mixpanel.track(...)
  }

  @override
  void onClose() {
    _flushTimer?.cancel();
    _flushEvents(); // Flush remaining events
    super.onClose();
  }
}

class AnalyticsEvent {
  final String name;
  final Map<String, dynamic>? parameters;
  final DateTime timestamp;

  AnalyticsEvent({
    required this.name,
    this.parameters,
    required this.timestamp,
  });
}
```

## Firebase Integration Best Practices Summary

### Why Firebase Should Be in ServiceLocator

**Problem**: FirebaseService was previously initialized separately in `main.dart`:
```dart
// ❌ OLD APPROACH (Anti-pattern)
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ServiceLocator.init();      // Services registered
  await FirebaseService.initialize(); // Firebase initialized separately

  runApp(const SovaApp());
}
```

**Issues with this approach:**
1. **Inconsistent Pattern**: Firebase treated differently from other services
2. **No Dependency Injection**: Can't use `Get.find<FirebaseService>()`
3. **Hard to Test**: Can't mock FirebaseService
4. **Order Issues**: If a service in ServiceLocator needs Firebase, it's not ready yet
5. **No State Tracking**: Can't check `FirebaseService.to.isInitialized`

**Solution**: Convert FirebaseService to GetxService and initialize it FIRST in ServiceLocator:
```dart
// ✅ NEW APPROACH (Best practice)
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ServiceLocator.init(); // Firebase + all services initialized together

  runApp(const SovaApp());
}

class ServiceLocator {
  static Future<void> init() async {
    // Step 1: Initialize Firebase FIRST
    final firebaseService = Get.put(FirebaseService(), permanent: true);
    await firebaseService.onInit();

    // Step 2: Other services can now safely use Firebase
    Get.put(AnalyticsService(), permanent: true); // Can use FirebaseAnalytics
  }
}
```

**Benefits:**
- ✅ **Centralized**: All initialization in one place
- ✅ **Testable**: Easy to mock with `Get.put<FirebaseService>(MockFirebaseService())`
- ✅ **Accessible**: `FirebaseService.to.isInitialized` available anywhere
- ✅ **Dependency Order**: Firebase guaranteed ready before dependent services
- ✅ **Consistent**: Firebase follows same pattern as other services

### Complete ServiceLocator with Firebase

```dart
// lib/services/service_locator.dart
class ServiceLocator {
  static Future<void> init() async {
    // ========== FOUNDATION LAYER ==========
    // Initialize critical infrastructure first
    final firebaseService = Get.put(FirebaseService(), permanent: true);
    await firebaseService.onInit();

    // ========== CORE SERVICES ==========
    // Independent services with no dependencies
    Get.put(ApiService(), permanent: true);

    // ========== FEATURE SERVICES ==========
    // Services that may depend on foundation or core services
    Get.put(AnalyticsService(), permanent: true);  // May use FirebaseAnalytics
    Get.put(AuthService(), permanent: true);       // May use FirebaseAuth
    Get.put(SubscribeService(), permanent: true);  // Independent
    Get.put(NotificationService(), permanent: true); // Depends on ApiService

    // ========== LOCALIZATION ==========
    // Initialize localization system
    await LocalizationBinding.ensureInitialized();

    // ========== SERVICE INITIALIZATION ==========
    // Trigger onInit() for services that need manual initialization
    await Get.find<SubscribeService>().onInit();
    Get.find<ApiService>().onInit();
  }
}
```

### Testing with FirebaseService

```dart
// test/services/analytics_service_test.dart
void main() {
  setUp(() async {
    Get.testMode = true;

    // Mock FirebaseService
    Get.put<FirebaseService>(
      MockFirebaseService(isInitialized: true),
      permanent: true,
    );

    // Now AnalyticsService can safely use Firebase
    Get.put(AnalyticsService(), permanent: true);
  });

  test('AnalyticsService logs events when Firebase is ready', () {
    final analytics = Get.find<AnalyticsService>();
    final firebase = Get.find<FirebaseService>();

    expect(firebase.isInitialized, true);
    analytics.logEvent('test_event');
    // Verify event logged to mock Firebase
  });
}
```

## Reference

- **Location**: `lib/services/service_locator.dart`
- **Firebase Service**: `lib/services/firebase_service.dart`
- **Initialization**: `lib/main.dart:9`
- **GetX Documentation**: https://pub.dev/packages/get
- **Service Examples**:
  - `lib/services/firebase_service.dart` (Foundation service)
  - `lib/services/api_service.dart` (Core service)
  - `lib/services/subscribe_service.dart` (Feature service)
  - `lib/services/analytics_service.dart` (Firebase-dependent service)
