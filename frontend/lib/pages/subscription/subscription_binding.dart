import 'package:get/get.dart';
import 'subscription_controller.dart';

/// 订阅页面的绑定
///
/// 用于初始化订阅页面所需的控制器和依赖
class SubscriptionBinding extends Bindings {
  @override
  void dependencies() {
    // 懒加载订阅控制器
    Get.lazyPut<SubscriptionController>(() => SubscriptionController());
  }
}
