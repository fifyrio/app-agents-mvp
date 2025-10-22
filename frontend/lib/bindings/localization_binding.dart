import 'package:get/get.dart';
import '../controllers/locale_controller.dart';
import '../services/localization_service.dart';

class LocalizationBinding extends Bindings {
  static Future<void> ensureInitialized() async {
    if (Get.isRegistered<LocalizationService>()) {
      return;
    }

    final localizationService = LocalizationService();
    await localizationService.init();

    Get.put<LocalizationService>(localizationService, permanent: true);
    Get.put<LocaleController>(
      LocaleController(localizationService: localizationService),
      permanent: true,
    );
  }

  @override
  void dependencies() {
    ensureInitialized();
  }
}
