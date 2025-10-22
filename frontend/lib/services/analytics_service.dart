import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'firebase_service.dart';

class AnalyticsService extends GetxService {
  static AnalyticsService get to => Get.find();

  FirebaseAnalytics? _analytics;
  FirebaseAnalyticsObserver? _observer;

  // Dependency injection
  FirebaseService get _firebaseService => Get.find<FirebaseService>();

  FirebaseAnalytics? get _instance {
    // Check if FirebaseService is initialized
    if (!_firebaseService.isInitialized) return null;

    try {
      _analytics ??= FirebaseAnalytics.instance;
      return _analytics;
    } catch (e) {
      if (kDebugMode) {
        print('❌ AnalyticsService: Firebase Analytics not available: $e');
      }
      return null;
    }
  }

  FirebaseAnalyticsObserver get observer {
    try {
      if (_observer == null && _instance != null) {
        _observer = FirebaseAnalyticsObserver(analytics: _instance!);
      }
      return _observer ?? FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);
    } catch (e) {
      if (kDebugMode) {
        print('❌ AnalyticsService: Observer not available: $e');
      }
      // Return a dummy observer that does nothing
      return FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      print('📊 AnalyticsService: Initialized');
    }
  }

  // App lifecycle events
  Future<void> logAppOpen() async {
    try {
      await _instance?.logAppOpen();
    } catch (e) {
      if (kDebugMode) {
        print('Analytics logAppOpen error: $e');
      }
    }
  }

  Future<void> logScreenView(String screenName) async {
    try {
      await _instance?.logScreenView(
        screenName: screenName,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Analytics logScreenView error: $e');
      }
    }
  }

  // Helper method to safely log events
  Future<void> _safeLogEvent(String name, Map<String, dynamic>? parameters) async {
    try {
      // Convert to Map<String, Object> as required by Firebase Analytics
      Map<String, Object>? convertedParams;
      if (parameters != null) {
        convertedParams = <String, Object>{};
        parameters.forEach((key, value) {
          if (value is bool) {
            convertedParams![key] = value.toString();
          } else if (value != null) {
            convertedParams![key] = value;
          }
        });
      }
      
      await _instance?.logEvent(
        name: name,
        parameters: convertedParams,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Analytics $name error: $e');
      }
    }
  }

  // User engagement events
  Future<void> logButtonClick(String buttonName, [Map<String, dynamic>? parameters]) async {
    await _safeLogEvent('button_click', {
      'button_name': buttonName,
      ...?parameters,
    });
  }

  // Image creation related events
  Future<void> logImageGenerated({
    required String tool,
    String? style,
    String? source,
  }) async {
    await _safeLogEvent('image_generated', {
      'tool': tool,
      if (style != null) 'style': style,
      if (source != null) 'source': source,
    });
  }

  Future<void> logImageUploaded() async {
    await _safeLogEvent('image_uploaded', null);
  }

  Future<void> logImageShared({required String method}) async {
    await _safeLogEvent('image_shared', {
      'method': method,
    });
  }

  Future<void> logImageSaved() async {
    await _safeLogEvent('image_saved', null);
  }

  // Premium/Pro events
  Future<void> logProFeatureAttempted({required String feature}) async {
    await _safeLogEvent('pro_feature_attempted', {
      'feature': feature,
    });
  }

  Future<void> logProUpgradeClicked({String? source}) async {
    await _safeLogEvent('pro_upgrade_clicked', {
      if (source != null) 'source': source,
    });
  }

  Future<void> logPurchaseStarted({required String productId}) async {
    await _safeLogEvent('purchase_started', {
      'product_id': productId,
    });
  }

  Future<void> logPurchaseCompleted({
    required String productId,
    required double value,
    required String currency,
  }) async {
    try {
      await _instance?.logPurchase(
        currency: currency,
        value: value,
        parameters: <String, Object>{
          'product_id': productId,
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Analytics logPurchaseCompleted error: $e');
      }
    }
  }

  // Navigation events
  Future<void> logPageView(String pageName, [Map<String, dynamic>? parameters]) async {
    await _safeLogEvent('page_view', {
      'page_name': pageName,
      ...?parameters,
    });
  }

  Future<void> logTabSwitch({required String tabName}) async {
    await _safeLogEvent('tab_switch', {
      'tab_name': tabName,
    });
  }

  // Tool selection events
  Future<void> logToolSelected({required String toolName}) async {
    await _safeLogEvent('tool_selected', {
      'tool_name': toolName,
    });
  }

  // Error tracking
  Future<void> logError({
    required String error,
    String? context,
  }) async {
    await _safeLogEvent('app_error', {
      'error': error,
      if (context != null) 'context': context,
    });
  }

  // User properties
  Future<void> setUserProperty({
    required String name,
    required String value,
  }) async {
    try {
      await _instance?.setUserProperty(name: name, value: value);
    } catch (e) {
      if (kDebugMode) {
        print('Analytics setUserProperty error: $e');
      }
    }
  }

  Future<void> setUserId(String userId) async {
    try {
      await _instance?.setUserId(id: userId);
    } catch (e) {
      if (kDebugMode) {
        print('Analytics setUserId error: $e');
      }
    }
  }

  // Settings and preferences
  Future<void> logSettingChanged({
    required String setting,
    required String value,
  }) async {
    await _safeLogEvent('setting_changed', {
      'setting': setting,
      'value': value,
    });
  }
}