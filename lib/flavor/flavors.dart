import 'package:loggy/loggy.dart';
import 'package:carey/core/constants/app_keys.dart';

enum Flavor {
  uae,
  uaeStaging,
  uaeHotfix,
  ksa,
  ksaStaging,
  ksaHotfix,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.uae:
        return 'TruDoc';
      case Flavor.uaeStaging:
        return '[STG] TruDoc';
      case Flavor.uaeHotfix:
        return '[HF] TruDoc';
      case Flavor.ksa:
        return 'TruDoc KSA';
      case Flavor.ksaStaging:
        return '[STG] TruDoc KSA';
      case Flavor.ksaHotfix:
        return '[HF] TruDoc KSA';
      default:
        return 'title';
    }
  }

  static String get envName {
    logDebug(appFlavor);
    switch (appFlavor) {
      case Flavor.uae:
        return '.env.carey.staging';
      case Flavor.uaeStaging:
        return '.env.carey.staging';
      case Flavor.uaeHotfix:
        return '.env.carey.staging';
      case Flavor.ksa:
        return '.env.carey.staging';
      default:
        return '.env.carey.staging';
    }
  }

  static String get appName {
    switch (appFlavor) {
      case Flavor.uae:
      case Flavor.uaeStaging:
      case Flavor.uaeHotfix:
        return "AppKeys.truDoc";
      case Flavor.ksa:
      case Flavor.ksaStaging:
      case Flavor.ksaHotfix:
        return AppKeys.ksa;
      default:
        return AppKeys.truDoc;
    }
  }

  static Map<String, dynamic>? get teleconsultionCites {
    switch (appFlavor) {
      case Flavor.uae:
      case Flavor.uaeStaging:
      case Flavor.uaeHotfix:
      case Flavor.ksa:
      case Flavor.ksaStaging:
      case Flavor.ksaHotfix:
        return {"Dubai": 35, "Abu Dhabi": 36, "Others": 37};
      default:
        return null;
    }
  }

  static Map<String, dynamic>? get teleconsultionPreference {
    switch (appFlavor) {
      case Flavor.uae:
      case Flavor.uaeStaging:
      case Flavor.uaeHotfix:
      case Flavor.ksa:
      case Flavor.ksaStaging:
      case Flavor.ksaHotfix:
        return {"Voice": "voice", "Video": "video"};
      default:
        return null;
    }
  }

  static Map<String, dynamic>? get teleconsultionType {
    switch (appFlavor) {
      case Flavor.uae:
      case Flavor.uaeStaging:
      case Flavor.uaeHotfix:
      case Flavor.ksa:
      case Flavor.ksaStaging:
      case Flavor.ksaHotfix:
        return {"Doctor": 1, "Psychologist": 2, "Dietitian": 3};
      default:
        return null;
    }
  }

  static String get apiAppFlavor {
    switch (appFlavor) {
      case Flavor.uae:
      case Flavor.uaeStaging:
      case Flavor.uaeHotfix:
      case Flavor.ksa:
      case Flavor.ksaStaging:
      case Flavor.ksaHotfix:
        return AppKeys.nexus;
      default:
        return AppKeys.nexus;
    }
  }

  static String get supportNumber {
    switch (appFlavor) {
      case Flavor.uae:
        return "800878362";
      case Flavor.uaeStaging:
      case Flavor.uaeHotfix:
      case Flavor.ksa:
      case Flavor.ksaStaging:
      case Flavor.ksaHotfix:
        return "0097143720101";
      default:
        return "0097143720101";
    }
  }
}
