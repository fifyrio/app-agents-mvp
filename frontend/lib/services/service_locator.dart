import 'package:get/get.dart';
import '../bindings/localization_binding.dart';
import 'firebase_service.dart';
import 'analytics_service.dart';
import 'subscribe_service.dart';
import 'media_download_service.dart';
import 'api/sova_api_service.dart';

class ServiceLocator {
  static Future<void> init() async {
    // Step 1: Initialize Firebase FIRST (other services may depend on it)
    final firebaseService = Get.put(FirebaseService(), permanent: true);
    await firebaseService.onInit();

    // Step 2: Initialize core services (API with Mixin architecture)
    Get.put(ApiService(), permanent: true);

    // Step 3: Initialize services that depend on Firebase
    Get.put(AnalyticsService(), permanent: true);

    // Step 4: Initialize other feature services
    Get.put(SubscribeService(), permanent: true);
    Get.put(MediaDownloadService(), permanent: true);

    // Step 5: Initialize localization (service + controller)
    await LocalizationBinding.ensureInitialized();

    // Step 6: Trigger onInit() for services that need it
    await Get.find<SubscribeService>().onInit();
    Get.find<ApiService>().onInit();
  }
}
