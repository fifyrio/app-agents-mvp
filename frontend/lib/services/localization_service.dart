import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/localization_config.dart';

class LocalizationService extends GetxService {
  static const String _languageCodeKey = 'language_code';

  final Rx<Locale> _locale = LocalizationConfig.fallbackLocale.obs;

  Rx<Locale> get locale => _locale;
  Locale get currentLocale => _locale.value;

  Future<LocalizationService> init() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCode = prefs.getString(_languageCodeKey);

    final initialLocale = savedCode != null ? Locale(savedCode) : LocalizationConfig.fallbackLocale;
    final resolvedLocale = LocalizationConfig.ensureSupported(initialLocale);
    _locale.value = resolvedLocale;
    Get.updateLocale(resolvedLocale);

    debugPrint('[Localization] Loaded locale: ${resolvedLocale.languageCode}');
    return this;
  }

  Future<void> setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    final target = LocalizationConfig.ensureSupported(locale);

    await prefs.setString(_languageCodeKey, target.languageCode);
    _locale.value = target;
    Get.updateLocale(target);

    debugPrint('[Localization] Updated locale to: ${target.languageCode}');
  }
}
