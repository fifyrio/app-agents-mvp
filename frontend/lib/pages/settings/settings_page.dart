import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'settings_controller.dart';

/// Settings Page
/// Displays app settings including notifications, appearance, and support options
class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  // Design colors matching the UI specification
  static const Color _backgroundColor = Color(0xFFF5F5F5);
  static const Color _iconBackgroundColor = Color(0xFFE6D9FF); // Light purple
  static const Color _iconColor = Color(0xFF9575CD); // Purple
  static const Color _sectionHeaderColor = Color(0xFF9E9E9E); // Gray
  static const Color _cardColor = Colors.white;
  static const Color _textColor = Color(0xFF212121);
  static const Color _secondaryTextColor = Color(0xFF757575);

  @override
  Widget build(BuildContext context) {
    // Initialize controller if not already bound
    Get.put(SettingsController());

    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            // General Section
            _buildSectionHeader('General'),
            const SizedBox(height: 12),
            _buildGeneralSection(),
            const SizedBox(height: 32),

            // Support Section
            _buildSectionHeader('Support'),
            const SizedBox(height: 12),
            _buildSupportSection(),
          ],
        ),
      ),
    );
  }

  /// Build custom app bar with back button and centered title
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: _backgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: _textColor),
        onPressed: () => Get.back(),
      ),
      title: const Text(
        'Settings',
        style: TextStyle(
          color: _textColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  /// Build section header with gray text
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: _sectionHeaderColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  /// Build General section with Notifications and Appearance
  Widget _buildGeneralSection() {
    return Container(
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Notifications row with toggle
          Obx(() => _buildSettingsRow(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            trailing: Switch(
              value: controller.notificationsEnabled,
              onChanged: controller.toggleNotifications,
              activeTrackColor: _iconColor.withValues(alpha: 0.5),
              activeThumbColor: _iconColor,
            ),
            onTap: null, // Disable tap since we have switch
          )),

          // Divider between items
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(height: 1, thickness: 1),
          ),

          // Appearance row with current theme
          Obx(() => _buildSettingsRow(
            icon: Icons.remove_red_eye_outlined,
            title: 'Appearance',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  controller.themeModeString,
                  style: const TextStyle(
                    fontSize: 16,
                    color: _secondaryTextColor,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.chevron_right,
                  color: _secondaryTextColor,
                  size: 20,
                ),
              ],
            ),
            onTap: controller.showThemeDialog,
          )),
        ],
      ),
    );
  }

  /// Build Support section with Help Center, Contact Us, and Privacy Policy
  Widget _buildSupportSection() {
    return Container(
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Help Center
          _buildSettingsRow(
            icon: Icons.help_outline,
            title: 'Help Center',
            trailing: const Icon(
              Icons.chevron_right,
              color: _secondaryTextColor,
              size: 20,
            ),
            onTap: controller.openHelpCenter,
          ),

          // Divider
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(height: 1, thickness: 1),
          ),

          // Contact Us
          _buildSettingsRow(
            icon: Icons.mail_outline,
            title: 'Contact Us',
            trailing: const Icon(
              Icons.chevron_right,
              color: _secondaryTextColor,
              size: 20,
            ),
            onTap: controller.openContactUs,
          ),

          // Divider
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(height: 1, thickness: 1),
          ),

          // Privacy Policy
          _buildSettingsRow(
            icon: Icons.shield_outlined,
            title: 'Privacy Policy',
            trailing: const Icon(
              Icons.chevron_right,
              color: _secondaryTextColor,
              size: 20,
            ),
            onTap: controller.openPrivacyPolicy,
          ),
        ],
      ),
    );
  }

  /// Build a settings row with icon, title, and trailing widget
  Widget _buildSettingsRow({
    required IconData icon,
    required String title,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              // Icon with circular background
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: _iconBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: _iconColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),

              // Title
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: _textColor,
                  ),
                ),
              ),

              // Trailing widget (switch, chevron, or theme text)
              trailing,
            ],
          ),
        ),
      ),
    );
  }
}
