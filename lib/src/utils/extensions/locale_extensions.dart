import 'package:flutter/material.dart';
import 'package:simple_do/src/utils/localization/app_locales.dart';

extension CheckLocale on Locale {
  bool get isArabic => this == arabicLocale;

  bool get isEnglish => this == englishLocale;
}
