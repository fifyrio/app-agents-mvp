import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

/// 设置页面
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
      ),
      body: ListView(
        children: [
          // 通用设置
          _buildSectionTitle('通用'),
          _buildSettingItem(
            icon: Icons.language,
            title: '语言',
            subtitle: '简体中文',
            onTap: () => Get.toNamed(AppRoutes.language),
          ),
          _buildSettingItem(
            icon: Icons.notifications,
            title: '通知',
            subtitle: '管理通知偏好',
            onTap: () {
              Get.snackbar(
                '提示',
                '通知设置功能开发中...',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          ),

          const Divider(height: 32),

          // 账户设置
          _buildSectionTitle('账户'),
          _buildSettingItem(
            icon: Icons.person,
            title: '个人资料',
            subtitle: '编辑个人信息',
            onTap: () => Get.toNamed(AppRoutes.profile),
          ),
          _buildSettingItem(
            icon: Icons.card_membership,
            title: '订阅管理',
            subtitle: '查看订阅状态',
            onTap: () => Get.toNamed(AppRoutes.subscription),
          ),

          const Divider(height: 32),

          // 关于
          _buildSectionTitle('关于'),
          _buildSettingItem(
            icon: Icons.info_outline,
            title: '关于 ColorWise',
            subtitle: '版本 1.0.0',
            onTap: () => Get.toNamed(AppRoutes.about),
          ),
          _buildSettingItem(
            icon: Icons.privacy_tip_outlined,
            title: '隐私政策',
            onTap: () => Get.toNamed(AppRoutes.privacy),
          ),
          _buildSettingItem(
            icon: Icons.description_outlined,
            title: '服务条款',
            onTap: () => Get.toNamed(AppRoutes.terms),
          ),
          _buildSettingItem(
            icon: Icons.help_outline,
            title: '帮助中心',
            onTap: () => Get.toNamed(AppRoutes.help),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFE91E63)),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}
