import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carey/core/constants/image_assets.dart';

const String languagePath = 'assets/i18n';

enum AppLocale { en, ar }

extension AppLocaleExtension on AppLocale {
  Locale get instance {
    switch (this) {
      case AppLocale.en:
        return const Locale('en', 'US');
      case AppLocale.ar:
        return const Locale('ar', 'AR');
      default:
        return const Locale('en', 'US');
    }
  }

  String get languageCode {
    switch (this) {
      case AppLocale.en:
        return 'en';
      case AppLocale.ar:
        return 'ar';
      default:
        return 'en';
    }
  }
}

class LanguageNameIcon {
  final Widget icon;
  final String name;

  LanguageNameIcon({required this.icon, required this.name});
}

