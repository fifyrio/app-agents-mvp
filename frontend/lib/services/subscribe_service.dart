import 'dart:async';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubscribeService extends GetxService {
  // RevenueCat Configuration
  static const String revenueCatOfferId = "default";
  static const String entitlementsId = "pro";
  static const String weeklyOfferId = "\$rc_weekly";
  static const String monthlyOfferId = "\$rc_monthly";

  // Credit Management Configuration
  static const int defaultFreeCredits = 1;
  static const String _creditsKey = 'user_credits';
  static const String _creditsInitializedKey = 'credits_initialized';

  // Observable states
  final RxBool isLoading = false.obs;
  final RxBool isSubscribed = false.obs;
  final Rx<CustomerInfo?> customerInfo = Rx<CustomerInfo?>(null);
  final Rx<Offerings?> offerings = Rx<Offerings?>(null);
  final RxString lastError = ''.obs;

  // Credit Management
  final RxInt availableCredits = 0.obs;

  Timer? _delayedLoadTimer;
  bool _initialLoadCompleted = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _initialize();
    await _initializeCredits();
    // Don't load data immediately - wait for app to be ready and user to grant network permission
    _scheduleDelayedLoad();
  }

  /// Initialize RevenueCat SDK
  Future<void> _initialize() async {
    try {
      const String apiKey = 'your key';

      await Purchases.setLogLevel(LogLevel.debug);

      PurchasesConfiguration configuration = PurchasesConfiguration(apiKey);
      await Purchases.configure(configuration);

      if (kDebugMode) {
        print('RevenueCat SubscribeService initialized successfully');
      }
    } catch (e) {
      lastError.value = 'Failed to initialize: $e';
      if (kDebugMode) {
        print('RevenueCat initialization error: $e');
      }
    }
  }

  /// Initialize credit system
  Future<void> _initializeCredits() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isInitialized = prefs.getBool(_creditsInitializedKey) ?? false;

      if (!isInitialized) {
        // First time user, give free credits
        await prefs.setInt(_creditsKey, defaultFreeCredits);
        await prefs.setBool(_creditsInitializedKey, true);
        availableCredits.value = defaultFreeCredits;

        if (kDebugMode) {
          print(
            'Credits initialized: $defaultFreeCredits free credits granted',
          );
        }
      } else {
        // Load existing credits
        final credits = prefs.getInt(_creditsKey) ?? 0;
        availableCredits.value = credits;

        if (kDebugMode) {
          print('Credits loaded: $credits available');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing credits: $e');
      }
      // Fallback to default credits
      availableCredits.value = defaultFreeCredits;
    }
  }

  /// Schedule delayed loading of data to allow for network permission
  void _scheduleDelayedLoad() {
    // Wait a bit for the app to fully initialize and user to potentially grant network permission
    _delayedLoadTimer = Timer(const Duration(seconds: 3), () async {
      if (!_initialLoadCompleted) {
        if (kDebugMode) {
          print('Attempting delayed offerings load...');
        }
        await _loadInitialData();
        _initialLoadCompleted = true;
      }
    });
  }

  /// Load initial customer info and offerings
  Future<void> _loadInitialData() async {
    // Sequential loading to avoid race conditions
    await refreshCustomerInfo();

    // Add a small delay before fetching offerings
    await Future.delayed(const Duration(milliseconds: 500));

    // Retry offerings fetch up to 3 times
    bool offeringsLoaded = false;
    int retryCount = 0;
    const maxRetries = 3;

    while (!offeringsLoaded && retryCount < maxRetries) {
      offeringsLoaded = await getOfferings();
      if (!offeringsLoaded) {
        retryCount++;
        if (retryCount < maxRetries) {
          if (kDebugMode) {
            print(
              'Retrying offerings fetch (attempt ${retryCount + 1}/$maxRetries)',
            );
          }
          await Future.delayed(
            Duration(seconds: retryCount * 2),
          ); // Exponential backoff
        }
      }
    }

    if (!offeringsLoaded && kDebugMode) {
      print('Failed to load offerings after $maxRetries attempts');
    }
  }

  /// Get available offerings from RevenueCat
  Future<bool> getOfferings() async {
    try {
      isLoading.value = true;
      lastError.value = '';

      // Simple network check - try to get offerings
      final fetchedOfferings = await Purchases.getOfferings();
      offerings.value = fetchedOfferings;

      // Validate that we have the expected packages
      final currentOffering = fetchedOfferings.current;
      if (currentOffering == null ||
          currentOffering.availablePackages.isEmpty) {
        throw Exception(
          'No subscription packages available. Please check your RevenueCat configuration.',
        );
      }

      if (kDebugMode) {
        print(
          'Offerings loaded: ${currentOffering.availablePackages.length} packages',
        );
        for (final package in currentOffering.availablePackages) {
          print(
            '  - ${package.identifier}: ${package.storeProduct.title} (${package.storeProduct.priceString})',
          );
        }
      }

      return true;
    } catch (e) {
      String errorMessage = 'Failed to get offerings: $e';

      // Provide more specific error messages
      if (e.toString().contains('network') ||
          e.toString().contains('connection') ||
          e.toString().contains('timeout')) {
        errorMessage =
            'Network connection issue. Please check your internet connection and try again.';
      } else if (e.toString().contains('configuration') ||
          e.toString().contains('packages')) {
        errorMessage =
            'Subscription packages not configured. Please try again later.';
      }

      lastError.value = errorMessage;
      if (kDebugMode) {
        print('Error getting offerings: $e');
      }
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Refresh customer info and update subscription status
  Future<bool> refreshCustomerInfo() async {
    try {
      isLoading.value = true;
      lastError.value = '';

      final info = await Purchases.getCustomerInfo();
      customerInfo.value = info;

      // Check if user has active pro entitlement
      isSubscribed.value = info.entitlements.active.containsKey(entitlementsId);

      if (kDebugMode) {
        print('Customer info refreshed. Is subscribed: ${isSubscribed.value}');
      }

      return true;
    } catch (e) {
      lastError.value = 'Failed to get customer info: $e';
      if (kDebugMode) {
        print('Error getting customer info: $e');
      }
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Check if user is currently subscribed
  bool get isPro => isSubscribed.value;

  /// Get weekly subscription package
  Package? get weeklyPackage {
    final currentOffering = offerings.value?.current;
    if (currentOffering == null) return null;

    return currentOffering.availablePackages.firstWhereOrNull(
      (package) => package.identifier == weeklyOfferId,
    );
  }

  /// Get monthly subscription package
  Package? get monthlyPackage {
    final currentOffering = offerings.value?.current;
    if (currentOffering == null) return null;

    return currentOffering.availablePackages.firstWhereOrNull(
      (package) => package.identifier == monthlyOfferId,
    );
  }

  /// Get all available packages
  List<Package> get availablePackages {
    return offerings.value?.current?.availablePackages ?? [];
  }

  /// Purchase a specific package
  Future<bool> purchasePackage(Package package) async {
    try {
      isLoading.value = true;
      lastError.value = '';

      final purchaseResult = await Purchases.purchasePackage(package);
      customerInfo.value = purchaseResult.customerInfo;

      // Update subscription status
      isSubscribed.value = purchaseResult.customerInfo.entitlements.active
          .containsKey(entitlementsId);

      if (kDebugMode) {
        print(
          'Purchase completed successfully. Is subscribed: ${isSubscribed.value}',
        );
      }

      return true;
    } on PlatformException catch (e) {
      final errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        lastError.value = 'Purchase was cancelled';
      } else if (errorCode == PurchasesErrorCode.paymentPendingError) {
        lastError.value = 'Payment is pending';
      } else {
        lastError.value = 'Purchase failed: ${e.message}';
      }

      if (kDebugMode) {
        print('Purchase error: ${e.message}');
      }
      return false;
    } catch (e) {
      lastError.value = 'Purchase failed: $e';
      if (kDebugMode) {
        print('Purchase error: $e');
      }
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Purchase weekly subscription
  Future<bool> purchaseWeekly() async {
    final package = weeklyPackage;
    if (package == null) {
      lastError.value = 'Weekly package not available';
      return false;
    }
    return await purchasePackage(package);
  }

  /// Purchase monthly subscription
  Future<bool> purchaseMonthly() async {
    final package = monthlyPackage;
    if (package == null) {
      lastError.value = 'Monthly package not available';
      return false;
    }
    return await purchasePackage(package);
  }

  /// Restore previous purchases
  /// Returns true if restoration was successful (regardless of whether purchases were found)
  /// Returns false only if there was an error during restoration
  Future<bool> restorePurchases() async {
    try {
      isLoading.value = true;
      lastError.value = '';

      final restoredInfo = await Purchases.restorePurchases();
      customerInfo.value = restoredInfo;

      // Update subscription status
      isSubscribed.value = restoredInfo.entitlements.active.containsKey(
        entitlementsId,
      );

      if (kDebugMode) {
        print(
          'Purchases restored successfully. Is subscribed: ${isSubscribed.value}',
        );
      }

      // Return true to indicate successful restoration, even if no active purchases found
      return true;
    } catch (e) {
      lastError.value = 'Failed to restore purchases: $e';
      if (kDebugMode) {
        print('Restore purchases error: $e');
      }
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Check if user has any active subscriptions after restore
  bool get hasActiveSubscription => isSubscribed.value;

  /// Set user ID for RevenueCat
  Future<bool> setUserId(String userId) async {
    try {
      await Purchases.logIn(userId);
      await refreshCustomerInfo();
      return true;
    } catch (e) {
      lastError.value = 'Failed to set user ID: $e';
      if (kDebugMode) {
        print('Error setting user ID: $e');
      }
      return false;
    }
  }

  /// Logout current user
  Future<bool> logout() async {
    try {
      await Purchases.logOut();
      customerInfo.value = null;
      isSubscribed.value = false;
      return true;
    } catch (e) {
      lastError.value = 'Failed to logout: $e';
      if (kDebugMode) {
        print('Error logging out: $e');
      }
      return false;
    }
  }

  /// Get subscription expiry date
  DateTime? get subscriptionExpiryDate {
    final entitlement = customerInfo.value?.entitlements.active[entitlementsId];
    final expiryDateString = entitlement?.expirationDate;
    if (expiryDateString == null) return null;
    try {
      return DateTime.parse(expiryDateString);
    } catch (e) {
      if (kDebugMode) {
        print('Error parsing expiry date: $e');
      }
      return null;
    }
  }

  /// Get subscription status string
  String get subscriptionStatus {
    if (!isSubscribed.value) return 'Free';

    final expiryDate = subscriptionExpiryDate;
    if (expiryDate == null) return 'Pro (Lifetime)';

    if (expiryDate.isBefore(DateTime.now())) {
      return 'Expired';
    }

    return 'Pro';
  }

  /// Clear error message
  void clearError() {
    lastError.value = '';
  }

  /// Check if offerings are loaded
  bool get hasOfferings => offerings.value != null;

  /// Manually retry loading offerings (useful if initial load failed)
  Future<bool> retryLoadOfferings() async {
    if (kDebugMode) {
      print('Manually retrying offerings load...');
    }
    return await getOfferings();
  }

  /// Force load data immediately (useful when user navigates to pricing page)
  Future<void> ensureDataLoaded() async {
    // Cancel any pending delayed load
    _delayedLoadTimer?.cancel();

    if (!_initialLoadCompleted || !hasOfferings) {
      if (kDebugMode) {
        print('Force loading subscription data...');
      }
      await _loadInitialData();
      _initialLoadCompleted = true;
    }
  }

  // ========== Credit Management ==========

  /// Check if user can use a feature (has credits or is subscribed)
  bool get canUseFeature => isPro || availableCredits.value > 0;

  /// Get current available credits (unlimited for Pro users)
  int get currentCredits =>
      isPro ? -1 : availableCredits.value; // -1 indicates unlimited

  /// Consume one credit (only for non-Pro users)
  Future<bool> consumeCredit({String? feature}) async {
    try {
      // Pro users have unlimited credits
      if (isPro) {
        if (kDebugMode) {
          print('Credit consumption skipped: User is Pro (unlimited)');
        }
        return true;
      }

      // Check if user has credits
      if (availableCredits.value <= 0) {
        if (kDebugMode) {
          print('Credit consumption failed: No credits available');
        }
        return false;
      }

      // Consume one credit
      final newCredits = availableCredits.value - 1;
      availableCredits.value = newCredits;

      // Save to persistent storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_creditsKey, newCredits);

      if (kDebugMode) {
        final featureInfo = feature != null ? ' for $feature' : '';
        print('Credit consumed$featureInfo. Remaining: $newCredits');
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error consuming credit: $e');
      }
      return false;
    }
  }

  /// Add credits (for testing or special promotions)
  Future<bool> addCredits(int amount, {String? reason}) async {
    try {
      // Pro users don't need credits
      if (isPro) {
        if (kDebugMode) {
          print('Credits not added: User is Pro (unlimited)');
        }
        return true;
      }

      if (amount <= 0) {
        if (kDebugMode) {
          print('Invalid credit amount: $amount');
        }
        return false;
      }

      final newCredits = availableCredits.value + amount;
      availableCredits.value = newCredits;

      // Save to persistent storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_creditsKey, newCredits);

      if (kDebugMode) {
        final reasonInfo = reason != null ? ' ($reason)' : '';
        print('Credits added: +$amount$reasonInfo. Total: $newCredits');
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error adding credits: $e');
      }
      return false;
    }
  }

  /// Reset credits to default (for testing)
  Future<void> resetCredits() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_creditsKey, defaultFreeCredits);
      availableCredits.value = defaultFreeCredits;

      if (kDebugMode) {
        print('Credits reset to default: $defaultFreeCredits');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error resetting credits: $e');
      }
    }
  }

  /// Refresh credits from storage (useful after purchase or restore)
  Future<void> refreshCredits() async {
    await _initializeCredits();
  }

  @override
  void onClose() {
    _delayedLoadTimer?.cancel();
    super.onClose();
  }
}

/// Extension to find package by identifier
extension ListExtension<T> on List<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (T element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
