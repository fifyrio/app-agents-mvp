import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/localization_service.dart';

class LocaleController extends GetxController {
  LocaleController({LocalizationService? localizationService})
      : _localizationService = localizationService ?? Get.find();

  final LocalizationService _localizationService;

  Rx<Locale> get localeStream => _localizationService.locale;
  Locale get locale => _localizationService.locale.value;

  Future<void> setLocale(Locale locale) => _localizationService.setLocale(locale);
}
