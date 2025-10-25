import 'package:get/get.dart';

/// 订阅类型枚举
enum SubscriptionType {
  weekly,
  yearly,
}

/// 订阅页面控制器
///
/// 管理订阅页面的状态和业务逻辑
class SubscriptionController extends GetxController {
  // ==================== 状态管理 ====================

  /// 当前选中的订阅类型
  final Rx<SubscriptionType> selectedType = SubscriptionType.yearly.obs;

  // ==================== 订阅信息 ====================

  /// 周订阅价格
  final double weeklyPrice = 4.99;

  /// 年订阅价格
  final double yearlyPrice = 39.99;

  /// 年订阅折扣百分比
  final int yearlyDiscount = 35;

  /// 专业功能列表
  final List<String> proFeatures = [
    'Unlimited daily analyses',
    'AI outfit previews',
    'Save & share looks',
    'Personal Style Card export',
  ];

  // ==================== 业务逻辑 ====================

  /// 选择订阅类型
  void selectSubscription(SubscriptionType type) {
    selectedType.value = type;
  }

  /// 继续订阅
  Future<void> continueToSubscribe() async {
    // TODO: 实现实际的订阅逻辑
    Get.snackbar(
      'Subscription',
      'Processing ${selectedType.value == SubscriptionType.weekly ? 'weekly' : 'yearly'} subscription...',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  /// 关闭订阅页面
  void close() {
    Get.back();
  }

  /// 打开服务条款
  void openTermsOfService() {
    // TODO: 实现打开服务条款页面
    Get.snackbar(
      'Info',
      'Opening Terms of Service...',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  /// 打开隐私政策
  void openPrivacyPolicy() {
    // TODO: 实现打开隐私政策页面
    Get.snackbar(
      'Info',
      'Opening Privacy Policy...',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
