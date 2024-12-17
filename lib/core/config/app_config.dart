import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loggy/loggy.dart';

class AppConfig {
  static Future<void> loadEnv(String fileName) async {
    logDebug("Loading .env $fileName");
    await dotenv.load(fileName: 'env/$fileName');
  }
}
