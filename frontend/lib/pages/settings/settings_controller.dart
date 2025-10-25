import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Settings page controller
/// Manages app settings including notifications and theme preferences
class SettingsController extends GetxController {
  // Observable state for notifications toggle
  final _notificationsEnabled = false.obs;

  // Observable state for theme mode
  final _themeMode = ThemeMode.system.obs;

  // SharedPreferences instance
  SharedPreferences? _prefs;

  // Keys for persistent storage
  static const String _keyNotifications = 'settings_notifications';
  static const String _keyThemeMode = 'settings_theme_mode';

  // Getters
  bool get notificationsEnabled => _notificationsEnabled.value;
  ThemeMode get themeMode => _themeMode.value;

  // Get current theme mode as display string
  String get themeModeString {
    switch (_themeMode.value) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  /// Load settings from persistent storage
  Future<void> _loadSettings() async {
    try {
      _prefs = await SharedPreferences.getInstance();

      // Load notifications preference
      _notificationsEnabled.value = _prefs?.getBool(_keyNotifications) ?? false;

      // Load theme mode preference
      final themeModeIndex = _prefs?.getInt(_keyThemeMode) ?? ThemeMode.system.index;
      _themeMode.value = ThemeMode.values[themeModeIndex];

      // Apply theme mode to app
      Get.changeThemeMode(_themeMode.value);
    } catch (e) {
      debugPrint('Error loading settings: $e');
    }
  }

  /// Toggle notifications on/off
  Future<void> toggleNotifications(bool value) async {
    try {
      _notificationsEnabled.value = value;
      await _prefs?.setBool(_keyNotifications, value);

      // Here you can add actual notification permission logic
      // For example: Firebase Messaging, local notifications, etc.
      debugPrint('Notifications ${value ? 'enabled' : 'disabled'}');
    } catch (e) {
      debugPrint('Error toggling notifications: $e');
    }
  }

  /// Change theme mode
  Future<void> changeThemeMode(ThemeMode mode) async {
    try {
      _themeMode.value = mode;
      await _prefs?.setInt(_keyThemeMode, mode.index);

      // Apply theme change immediately
      Get.changeThemeMode(mode);

      debugPrint('Theme mode changed to: ${mode.toString()}');
    } catch (e) {
      debugPrint('Error changing theme mode: $e');
    }
  }

  /// Navigate to Help Center
  void openHelpCenter() {
    // TODO: Implement help center navigation
    Get.snackbar(
      'Help Center',
      'Opening help center...',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  /// Navigate to Contact Us
  void openContactUs() {
    // TODO: Implement contact form or email
    Get.snackbar(
      'Contact Us',
      'Opening contact form...',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  /// Navigate to Privacy Policy
  void openPrivacyPolicy() {
    // TODO: Implement privacy policy page
    Get.snackbar(
      'Privacy Policy',
      'Opening privacy policy...',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  /// Show theme selection dialog
  void showThemeDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Appearance',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              _buildThemeOption(ThemeMode.light, 'Light'),
              const SizedBox(height: 16),
              _buildThemeOption(ThemeMode.dark, 'Dark'),
              const SizedBox(height: 16),
              _buildThemeOption(ThemeMode.system, 'System'),
            ],
          ),
        ),
      ),
    );
  }

  /// Build theme option radio button
  Widget _buildThemeOption(ThemeMode mode, String label) {
    return Obx(() {
      final isSelected = _themeMode.value == mode;
      return InkWell(
        onTap: () {
          changeThemeMode(mode);
          Get.back();
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? const Color(0xFF9575CD) : Colors.grey,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF9575CD),
                          ),
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              Text(
                label,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      );
    });
  }
}
