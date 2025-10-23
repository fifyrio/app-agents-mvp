import 'package:get/get.dart';

/// 设置页面的绑定
///
/// 用于初始化设置页面所需的控制器和依赖
class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    // 如果需要SettingsController可以在这里注入
    // Get.lazyPut<SettingsController>(() => SettingsController());

    // 目前设置页面比较简单，暂时不需要专门的Controller
  }
}
