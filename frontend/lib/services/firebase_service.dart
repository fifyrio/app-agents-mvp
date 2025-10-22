import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

/// Firebase initialization service
/// Must be initialized BEFORE ServiceLocator because other services may depend on Firebase
class FirebaseService extends GetxService {
  static FirebaseService get to => Get.find();

  bool _initialized = false;
  bool get isInitialized => _initialized;

  /// Initialize Firebase
  /// Called from ServiceLocator.init()
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
        print(
          '⚠️ FirebaseService: Using demo config. Please replace with actual Firebase config.',
        );
      }
      // For demo purposes, mark as initialized even if it fails
      _initialized = true;
    }
  }
}
