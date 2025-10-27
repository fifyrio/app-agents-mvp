import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'subscription_controller.dart';

/// 订阅页面 - Upgrade to Pro
///
/// 展示订阅选项和专业功能，允许用户升级到Pro版本
class SubscriptionPage extends GetView<SubscriptionController> {
  const SubscriptionPage({super.key});

  // 主题紫色 - 从设计中提取的紫色
  static const Color primaryPurple = Color(0xFF7C3AED);
  static const Color lightGray = Color(0xFFF5F5F5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGray,
      body: SafeArea(
        child: Column(
          children: [
            // 顶部标题栏
            _buildHeader(context),

            // 可滚动内容
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 24),

                    // 产品图片
                    _buildProductImage(),

                    const SizedBox(height: 40),

                    // 订阅选项卡片
                    _buildSubscriptionCards(),

                    const SizedBox(height: 24),

                    // 功能列表
                    _buildFeaturesCard(),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // 底部按钮和条款
            _buildBottomSection(context),
          ],
        ),
      ),
    );
  }

  /// 构建顶部标题栏
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          // 关闭按钮
          IconButton(
            icon: const Icon(Icons.close, size: 28),
            onPressed: () => controller.close(),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 16),

          // 标题
          const Text(
            'Upgrade to Pro',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建产品图片
  Widget _buildProductImage() {
    return Container(
      width: 140,
      height: 180,
      decoration: BoxDecoration(
        color: const Color(0xFFE5B299), // 桃色/米色
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 24,
            offset: const Offset(0, 12),
            spreadRadius: -8,
          ),
        ],
      ),
    );
  }

  /// 构建订阅选项卡片
  Widget _buildSubscriptionCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // 周订阅卡片
          Obx(() => _buildSubscriptionCard(
                type: SubscriptionType.weekly,
                title: 'Weekly',
                price: controller.weeklyPrice,
                period: 'week',
                isSelected: controller.selectedType.value == SubscriptionType.weekly,
              )),

          const SizedBox(height: 16),

          // 年订阅卡片
          Obx(() => _buildSubscriptionCard(
                type: SubscriptionType.yearly,
                title: 'Yearly',
                price: controller.yearlyPrice,
                period: 'year',
                isSelected: controller.selectedType.value == SubscriptionType.yearly,
                discountBadge: 'Save ${controller.yearlyDiscount}%',
              )),
        ],
      ),
    );
  }

  /// 构建单个订阅卡片
  Widget _buildSubscriptionCard({
    required SubscriptionType type,
    required String title,
    required double price,
    required String period,
    required bool isSelected,
    String? discountBadge,
  }) {
    return GestureDetector(
      onTap: () => controller.selectSubscription(type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? primaryPurple : Colors.grey.shade300,
            width: isSelected ? 3 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primaryPurple.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 左侧内容
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '\$${price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: ' / $period',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 右侧折扣徽章（仅年订阅显示）
            if (discountBadge != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: primaryPurple,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  discountBadge,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// 构建功能列表卡片
  Widget _buildFeaturesCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题
          const Text(
            'Included Features (Pro Only)',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),

          // 功能列表
          ...controller.proFeatures.map((feature) => _buildFeatureItem(feature)),
        ],
      ),
    );
  }

  /// 构建单个功能项
  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          // 紫色勾选图标
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: primaryPurple,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 16,
            ),
          ),
          const SizedBox(width: 16),

          // 功能文本
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建底部按钮和条款区域
  Widget _buildBottomSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 继续订阅按钮
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () => controller.continueToSubscribe(),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryPurple,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: const Text(
                'Continue to Subscribe',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Restore Purchase 按钮
          TextButton(
            onPressed: () => controller.restorePurchase(),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: Text(
              'Restore Purchase',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // 条款文本
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                height: 1.5,
              ),
              children: [
                const TextSpan(text: 'By continuing, you agree to our '),
                TextSpan(
                  text: 'Terms of Service',
                  style: TextStyle(
                    color: Colors.grey[800],
                    decoration: TextDecoration.underline,
                  ),
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    color: Colors.grey[800],
                    decoration: TextDecoration.underline,
                  ),
                ),
                const TextSpan(text: '.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
