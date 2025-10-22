# GetX App Entry Point Best Practices

You are a Flutter app architecture expert specializing in GetX-based application entry points and navigation patterns.

## Overview

This document covers best practices for building a robust Flutter app entry point using GetX, including:
- Reactive navigation with `Obx()` for conditional routing
- Splash screen and async initialization
- Onboarding flow management
- Bottom navigation with `IndexedStack`
- Centralized route configuration with `getPages`

## App Entry Point Architecture

### Core Pattern: FutureBuilder + Obx for Dynamic Navigation

The app uses a two-layer reactive pattern:
1. **FutureBuilder**: Handle async initialization (splash screen, permissions)
2. **Obx**: Reactively switch between onboarding and main app based on state

### Complete App.dart Implementation

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config/theme_config.dart';
import 'config/app_routes.dart';
import 'config/localization_config.dart';
import 'services/analytics_service.dart';
import 'containers/main_container.dart';
import 'pages/pricing_page.dart';
import 'pages/settings_page.dart';
import 'pages/onboarding_page.dart';
import 'pages/splash_page.dart';
import 'controllers/onboarding_controller.dart';
import 'services/app_tracking_service.dart';
import 'controllers/locale_controller.dart';

class SovaApp extends StatefulWidget {
  const SovaApp({super.key});

  @override
  State<SovaApp> createState() => _SovaAppState();
}

class _SovaAppState extends State<SovaApp> {
  late final LocaleController _localeController;

  @override
  void initState() {
    super.initState();
    // Get locale controller registered in ServiceLocator
    _localeController = Get.find<LocaleController>();
  }

  /// App initialization logic
  /// - Splash screen delay for animations
  /// - Request iOS App Tracking Transparency (ATT) permission
  Future<void> _initializeApp() async {
    // Wait for splash screen animations (1.5 seconds)
    await Future.delayed(const Duration(milliseconds: 1500));

    // Request ATT permission after splash, before main UI
    // This is Apple's recommended timing
    await AppTrackingService.requestTrackingPermission();
  }

  @override
  Widget build(BuildContext context) {
    // Outer Obx: Watch for locale changes
    return Obx(() {
      final locale = _localeController.locale;

      return GetMaterialApp(
        title: 'Sova - AI Image Processing',
        theme: AppThemeConfig.lightTheme,
        debugShowCheckedModeBanner: false,

        // Analytics observer for screen tracking
        navigatorObservers: [AnalyticsService.observer],

        // Localization configuration
        localizationsDelegates: LocalizationConfig.delegates,
        supportedLocales: LocalizationConfig.supportedLocales,
        fallbackLocale: LocalizationConfig.fallbackLocale,
        locale: locale,

        // Home: FutureBuilder for async initialization
        home: FutureBuilder(
          future: _initializeApp(),
          builder: (context, snapshot) {
            // Show splash while initializing
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashPage();
            }

            // Initialize OnboardingController after async operations
            final onboardingController = Get.put(OnboardingController());

            // Inner Obx: Watch for onboarding status changes
            return Obx(() {
              // Show loading while checking onboarding status
              if (onboardingController.isLoading.value) {
                return const Scaffold(
                  backgroundColor: Colors.black,
                  body: Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFE91E63),
                    ),
                  ),
                );
              }

              // Reactively switch between onboarding and main app
              return onboardingController.hasSeenOnboarding.value
                  ? const MainContainer()
                  : const OnboardingPage();
            });
          },
        ),

        // Named routes configuration
        getPages: [
          // Bottom navigation tabs (with initial index)
          GetPage(
            name: AppRoutes.home,
            page: () => const MainContainer(initialIndex: 0),
          ),
          GetPage(
            name: AppRoutes.studio,
            page: () => const MainContainer(initialIndex: 1),
          ),
          GetPage(
            name: AppRoutes.analyze,
            page: () => const MainContainer(initialIndex: 2),
          ),
          GetPage(
            name: AppRoutes.profile,
            page: () => const MainContainer(initialIndex: 3),
          ),

          // Full-screen pages
          GetPage(
            name: AppRoutes.pricing,
            page: () => const PricingPage(),
          ),
          GetPage(
            name: AppRoutes.settings,
            page: () => const SettingsPage(),
          ),

          // Pages with arguments
          GetPage(
            name: AppRoutes.videoResult,
            page: () => VideoResultPage(
              videoUrl: Get.arguments['videoUrl'] as String,
              taskId: Get.arguments['taskId'] as String,
              marketingInfo: Get.arguments['marketingInfo'] as List<Map<String, String>>?,
            ),
          ),
          GetPage(
            name: AppRoutes.promptPreview,
            page: () => const PromptPreviewPage(),
          ),
        ],
      );
    });
  }
}
```

## Key Architecture Patterns

### 1. Nested Obx Pattern for Multi-Level Reactivity

```dart
// Outer Obx: Watch locale changes (app-wide)
return Obx(() {
  final locale = _localeController.locale;

  return GetMaterialApp(
    locale: locale,

    home: FutureBuilder(
      // Inner Obx: Watch onboarding status (user-specific)
      builder: (context, snapshot) {
        return Obx(() {
          return controller.hasSeenOnboarding.value
              ? const MainContainer()
              : const OnboardingPage();
        });
      },
    ),
  );
});
```

**Benefits:**
- ✅ **Locale reactivity**: App rebuilds when language changes
- ✅ **Onboarding reactivity**: Automatically navigate when onboarding completes
- ✅ **Separation of concerns**: Each Obx watches a single responsibility

### 2. FutureBuilder for Async Initialization

```dart
Future<void> _initializeApp() async {
  // Step 1: Wait for splash animations
  await Future.delayed(const Duration(milliseconds: 1500));

  // Step 2: Request permissions at optimal timing
  await AppTrackingService.requestTrackingPermission();

  // Step 3: Other async initialization
  // await AnalyticsService.initialize();
  // await RemoteConfigService.fetchConfig();
}

home: FutureBuilder(
  future: _initializeApp(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const SplashPage(); // Show splash
    }

    // Initialization complete, show main UI
    return /* main content */;
  },
)
```

**Best Practices:**
- ✅ Use `FutureBuilder` for one-time async operations
- ✅ Show splash screen during initialization
- ✅ Request permissions after splash, before main UI
- ✅ Keep initialization logic in a separate method

### 3. Conditional Controller Registration

```dart
// ❌ WRONG: Register controller in initState
@override
void initState() {
  super.initState();
  Get.put(OnboardingController()); // Registered too early
}

// ✅ CORRECT: Register after async initialization
home: FutureBuilder(
  future: _initializeApp(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const SplashPage();
    }

    // Register controller AFTER initialization completes
    final onboardingController = Get.put(OnboardingController());

    return Obx(() {
      // Use controller
    });
  },
)
```

**Why?**
- Controllers can safely access initialized services
- Prevents race conditions with ServiceLocator
- Controllers are only created when actually needed

## OnboardingController Pattern

### Controller Implementation

```dart
class OnboardingController extends GetxController {
  static const String _hasSeenOnboardingKey = 'has_seen_onboarding';

  // Reactive state
  final RxInt currentIndex = 0.obs;
  final RxBool hasSeenOnboarding = false.obs;
  final RxBool isLoading = true.obs;

  List<OnboardingItem> items = [];

  void initializeItems(AppLocalizations l10n) {
    items = OnboardingItem.getItems(l10n);
  }

  @override
  void onInit() {
    super.onInit();
    _checkOnboardingStatus();
  }

  /// Load onboarding status from persistent storage
  Future<void> _checkOnboardingStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      hasSeenOnboarding.value = prefs.getBool(_hasSeenOnboardingKey) ?? false;
    } catch (e) {
      print('Error checking onboarding status: $e');
      hasSeenOnboarding.value = false;
    } finally {
      isLoading.value = false; // Signal loading complete
    }
  }

  /// Mark onboarding as complete
  Future<void> completeOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_hasSeenOnboardingKey, true);
      hasSeenOnboarding.value = true; // Triggers reactive navigation
    } catch (e) {
      print('Error saving onboarding status: $e');
    }
  }

  // Navigation methods
  void nextSlide() {
    if (currentIndex.value < items.length - 1) {
      currentIndex.value++;
    }
  }

  void previousSlide() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
    }
  }

  bool get isLastSlide => currentIndex.value == items.length - 1;
}
```

**Key Features:**
- ✅ **Three-state pattern**: `isLoading` → `hasSeenOnboarding` → Content
- ✅ **Persistent storage**: Uses SharedPreferences
- ✅ **Reactive navigation**: Changing `hasSeenOnboarding` triggers UI update
- ✅ **Error handling**: Graceful fallback on storage errors

### Usage in OnboardingPage

```dart
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardingController>();
    final l10n = AppLocalizations.of(context)!;

    controller.initializeItems(l10n);

    return Scaffold(
      body: PageView.builder(
        itemCount: controller.items.length,
        onPageChanged: (index) => controller.currentIndex.value = index,
        itemBuilder: (context, index) => OnboardingSlide(
          item: controller.items[index],
        ),
      ),
      bottomSheet: Obx(() => controller.isLastSlide
        ? ElevatedButton(
            onPressed: controller.completeOnboarding, // Triggers navigation
            child: Text('Get Started'),
          )
        : TextButton(
            onPressed: controller.nextSlide,
            child: Text('Next'),
          )
      ),
    );
  }
}
```

## MainContainer Pattern: Bottom Navigation with IndexedStack

### Why IndexedStack?

`IndexedStack` preserves the state of each tab, unlike `PageView` or conditionally rendering widgets.

### MainContainer Implementation

```dart
class MainContainer extends StatefulWidget {
  final int initialIndex;

  const MainContainer({
    super.key,
    this.initialIndex = 0, // Support deep linking
  });

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; // Set initial tab
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack: All children are built, only one is visible
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomePageContent(),
          StudioPageContent(),
          AnalyzePageContent(),
          ProfilePageContent(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Color(0xFF2C1810),
        border: Border(
          top: BorderSide(color: Color(0xFF3A2B1E), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomNavItem(Icons.home, l10n.navHome, 0),
          _buildBottomNavItem(Icons.video_library, l10n.navStudio, 1),
          _buildBottomNavItem(Icons.analytics, l10n.navAnalyze, 2),
          _buildBottomNavItem(Icons.person, l10n.navProfile, 3),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, int index) {
    final bool isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () => _onBottomNavTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFFE91E63) : Colors.grey,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFFE91E63) : Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
```

**Benefits of IndexedStack:**
- ✅ **State preservation**: Each tab maintains its scroll position, form data, etc.
- ✅ **Fast switching**: No rebuild on tab change, just visibility toggle
- ✅ **Deep linking**: Support `initialIndex` for named routes

**Trade-offs:**
- ⚠️ All tabs are built upfront (higher initial memory)
- ⚠️ Not suitable for 10+ tabs (use lazy loading instead)

### Deep Linking with MainContainer

```dart
// Routes configuration supports direct tab navigation
GetPage(
  name: AppRoutes.home,
  page: () => const MainContainer(initialIndex: 0),
),
GetPage(
  name: AppRoutes.studio,
  page: () => const MainContainer(initialIndex: 1),
),

// Usage
Get.toNamed(AppRoutes.studio); // Opens MainContainer with Studio tab active
```

## GetPages Configuration

### Centralized Route Configuration

```dart
// lib/config/app_routes.dart
class AppRoutes {
  // Authentication flow
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';

  // Main app (bottom navigation)
  static const String home = '/home';
  static const String studio = '/studio';
  static const String analyze = '/analyze';
  static const String profile = '/profile';

  // Feature pages
  static const String pricing = '/pricing';
  static const String settings = '/settings';
  static const String videoResult = '/video-result';
  static const String promptPreview = '/prompt-preview';
  static const String analyzeImages = '/analyze-images';
}
```

### GetPages Best Practices

```dart
getPages: [
  // ===== Bottom Navigation Tabs =====
  // Each tab route creates MainContainer with specific initialIndex
  GetPage(
    name: AppRoutes.home,
    page: () => const MainContainer(initialIndex: 0),
  ),
  GetPage(
    name: AppRoutes.studio,
    page: () => const MainContainer(initialIndex: 1),
  ),

  // ===== Simple Pages (No Arguments) =====
  GetPage(
    name: AppRoutes.pricing,
    page: () => const PricingPage(),
  ),
  GetPage(
    name: AppRoutes.settings,
    page: () => const SettingsPage(),
  ),

  // ===== Pages with Arguments =====
  GetPage(
    name: AppRoutes.videoResult,
    page: () => VideoResultPage(
      // Access arguments via Get.arguments
      videoUrl: Get.arguments['videoUrl'] as String,
      taskId: Get.arguments['taskId'] as String,
      marketingInfo: Get.arguments['marketingInfo'] as List<Map<String, String>>?,
    ),
  ),

  // ===== Pages with Transitions =====
  GetPage(
    name: AppRoutes.promptPreview,
    page: () => const PromptPreviewPage(),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 300),
  ),

  // ===== Pages with Middleware =====
  GetPage(
    name: AppRoutes.profile,
    page: () => const ProfilePage(),
    middlewares: [AuthMiddleware()], // Require authentication
  ),

  // ===== Pages with Bindings =====
  GetPage(
    name: AppRoutes.videoResult,
    page: () => const VideoResultPage(),
    binding: VideoResultBinding(), // Auto-register controllers
  ),
]
```

### Navigation Patterns

```dart
// 1. Simple navigation
Get.toNamed(AppRoutes.pricing);

// 2. Navigation with arguments
Get.toNamed(
  AppRoutes.videoResult,
  arguments: {
    'videoUrl': 'https://example.com/video.mp4',
    'taskId': 'task_123',
    'marketingInfo': [
      {'title': 'Feature 1', 'description': 'Description 1'},
    ],
  },
);

// 3. Navigation with parameters (query params)
Get.toNamed('${AppRoutes.settings}?theme=dark');

// 4. Replace current route
Get.offNamed(AppRoutes.home); // Can't go back

// 5. Replace all routes
Get.offAllNamed(AppRoutes.onboarding); // Clear navigation stack

// 6. Back navigation
Get.back();
Get.back(result: {'success': true}); // Return data
```

## Complete App Flow Diagram

```
main.dart
  │
  └─> ServiceLocator.init()
        ├─> Register ApiService
        ├─> Register SubscribeService
        └─> Register LocaleController
  │
  └─> runApp(SovaApp())
        │
        └─> _SovaAppState
              │
              ├─> Obx (locale)
              │     └─> GetMaterialApp
              │           │
              │           ├─> home: FutureBuilder
              │           │     │
              │           │     ├─> _initializeApp()
              │           │     │     ├─> Splash delay (1.5s)
              │           │     │     └─> Request ATT permission
              │           │     │
              │           │     └─> Obx (onboarding status)
              │           │           │
              │           │           ├─> if isLoading
              │           │           │     └─> Loading indicator
              │           │           │
              │           │           ├─> if hasSeenOnboarding
              │           │           │     └─> MainContainer
              │           │           │           ├─> IndexedStack
              │           │           │           │     ├─> HomePageContent
              │           │           │           │     ├─> StudioPageContent
              │           │           │           │     ├─> AnalyzePageContent
              │           │           │           │     └─> ProfilePageContent
              │           │           │           └─> BottomNavigationBar
              │           │           │
              │           │           └─> else
              │           │                 └─> OnboardingPage
              │           │                       └─> completeOnboarding()
              │           │                             └─> hasSeenOnboarding = true
              │           │                                   └─> Auto navigate to MainContainer
              │           │
              │           └─> getPages: [...]
              │                 ├─> /home → MainContainer(0)
              │                 ├─> /studio → MainContainer(1)
              │                 ├─> /pricing → PricingPage()
              │                 └─> /video-result → VideoResultPage(args)
              │
              └─> navigatorObservers: [AnalyticsService.observer]
```

## Best Practices Summary

### ✅ DO

1. **Use FutureBuilder for async initialization**
   ```dart
   home: FutureBuilder(
     future: _initializeApp(),
     builder: (context, snapshot) {
       if (snapshot.connectionState == ConnectionState.waiting) {
         return const SplashPage();
       }
       return /* main content */;
     },
   )
   ```

2. **Use Obx for reactive navigation**
   ```dart
   return Obx(() {
     return controller.hasSeenOnboarding.value
         ? const MainContainer()
         : const OnboardingPage();
   });
   ```

3. **Register controllers after async initialization**
   ```dart
   builder: (context, snapshot) {
     if (snapshot.connectionState == ConnectionState.done) {
       final controller = Get.put(OnboardingController());
       // Use controller
     }
   }
   ```

4. **Use IndexedStack for bottom navigation**
   ```dart
   body: IndexedStack(
     index: _currentIndex,
     children: const [
       HomePageContent(),
       StudioPageContent(),
     ],
   )
   ```

5. **Centralize routes in AppRoutes class**
   ```dart
   class AppRoutes {
     static const String home = '/home';
     static const String pricing = '/pricing';
   }
   ```

6. **Support deep linking with initialIndex**
   ```dart
   GetPage(
     name: AppRoutes.studio,
     page: () => const MainContainer(initialIndex: 1),
   )
   ```

### ❌ DON'T

1. **Don't use Navigator.push with GetX**
   ```dart
   // ❌ WRONG
   Navigator.push(context, MaterialPageRoute(builder: (_) => Page()));

   // ✅ CORRECT
   Get.toNamed(AppRoutes.page);
   ```

2. **Don't register controllers in initState**
   ```dart
   // ❌ WRONG
   @override
   void initState() {
     Get.put(OnboardingController());
   }

   // ✅ CORRECT
   builder: (context, snapshot) {
     final controller = Get.put(OnboardingController());
   }
   ```

3. **Don't use PageView for bottom navigation if you need state preservation**
   ```dart
   // ❌ WRONG: Rebuilds tabs on switch
   PageView(
     children: [HomePage(), ProfilePage()],
   )

   // ✅ CORRECT: Preserves state
   IndexedStack(
     children: [HomePage(), ProfilePage()],
   )
   ```

4. **Don't hardcode routes**
   ```dart
   // ❌ WRONG
   Get.toNamed('/pricing');

   // ✅ CORRECT
   Get.toNamed(AppRoutes.pricing);
   ```

5. **Don't pass complex arguments in constructor**
   ```dart
   // ❌ WRONG: Breaks with named routes
   GetPage(
     name: '/result',
     page: () => ResultPage(videoUrl: ???), // Can't access arguments
   )

   // ✅ CORRECT: Use Get.arguments
   GetPage(
     name: '/result',
     page: () => ResultPage(
       videoUrl: Get.arguments['videoUrl'] as String,
     ),
   )
   ```

## Testing

### Testing App Initialization

```dart
testWidgets('App shows splash then onboarding for new users', (tester) async {
  await tester.pumpWidget(const SovaApp());

  // Should show splash initially
  expect(find.byType(SplashPage), findsOneWidget);

  // Wait for initialization
  await tester.pumpAndSettle(const Duration(seconds: 2));

  // Should show onboarding for new users
  expect(find.byType(OnboardingPage), findsOneWidget);
});

testWidgets('App shows MainContainer for returning users', (tester) async {
  // Mock SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('has_seen_onboarding', true);

  await tester.pumpWidget(const SovaApp());
  await tester.pumpAndSettle(const Duration(seconds: 2));

  // Should show main app
  expect(find.byType(MainContainer), findsOneWidget);
});
```

### Testing Navigation

```dart
testWidgets('Bottom navigation switches tabs', (tester) async {
  await tester.pumpWidget(const MainContainer());

  // Initially on home tab
  expect(find.byType(HomePageContent), findsOneWidget);

  // Tap studio tab
  await tester.tap(find.text('Studio'));
  await tester.pumpAndSettle();

  // Should show studio tab
  expect(find.byType(StudioPageContent), findsOneWidget);
});
```

## Migration Checklist

When implementing this pattern in a new project:

- [ ] Create `lib/app.dart` with StatefulWidget
- [ ] Implement `_initializeApp()` for async operations
- [ ] Use FutureBuilder for splash screen handling
- [ ] Create OnboardingController with three-state pattern
- [ ] Use nested Obx for locale and onboarding reactivity
- [ ] Create MainContainer with IndexedStack
- [ ] Support `initialIndex` for deep linking
- [ ] Create `lib/config/app_routes.dart`
- [ ] Configure `getPages` in GetMaterialApp
- [ ] Add navigator observers for analytics
- [ ] Use `Get.toNamed()` instead of `Navigator.push()`
- [ ] Test onboarding flow for new vs returning users
- [ ] Test deep linking to specific tabs
- [ ] Test navigation with arguments

## Reference

- **App Entry**: `lib/app.dart`
- **Routes**: `lib/config/app_routes.dart`
- **Container**: `lib/containers/main_container.dart`
- **Controllers**: `lib/controllers/onboarding_controller.dart`
- **GetX Documentation**: https://pub.dev/packages/get
- **Navigation Guide**: https://github.com/jonataslaw/getx#navigation
