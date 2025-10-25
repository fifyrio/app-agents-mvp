import 'package:get/get.dart';
import 'settings_controller.dart';

/// Settings page binding
///
/// Initializes the SettingsController when the settings page is accessed
class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy load the SettingsController (only created when needed)
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}
