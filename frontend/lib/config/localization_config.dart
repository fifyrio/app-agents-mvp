import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../l10n/app_localizations.dart';

class LocalizationConfig {
  static const Locale fallbackLocale = Locale('en');

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('zh'),
    Locale('de'),
    Locale('is'),
  ];

  static const List<LocalizationsDelegate<dynamic>> delegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static bool isSupported(Locale locale) {
    return supportedLocales.any(
      (supported) => supported.languageCode == locale.languageCode,
    );
  }

  static Locale ensureSupported(Locale locale) {
    return isSupported(locale) ? locale : fallbackLocale;
  }
}
