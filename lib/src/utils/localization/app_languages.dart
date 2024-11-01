import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:restart/restart.dart';

import '../../core/data_sources/local/local_storage.dart';
import '../../di/services_locator.dart';
import 'app_locales.dart';

abstract class AppLanguages {
  static void setLocale(BuildContext context, Locale locale) {
    if (allLocales.contains(locale)) {
      context.setLocale(locale);
      getIt.get<LocalStorage>().storeLanguage(locale.toStringWithSeparator());
      restart();
    } else {
      throw Exception('App does not support this locale');
    }
  }

  static Locale get getCurrentLocale {
    Locale defaultLocale = englishLocale;
    String? temp = getIt.get<LocalStorage>().language;
    if (temp == null) {
      return defaultLocale;
    } else {
      switch (temp) {
        case 'ar':
          return arabicLocale;
        case 'en':
          return englishLocale;
        default:
          return defaultLocale;
      }
    }
  }

  static bool get isArabic => getCurrentLocale == arabicLocale;

  static bool get isEnglish => getCurrentLocale == englishLocale;
}
