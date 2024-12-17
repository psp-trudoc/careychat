import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';

class AppLogger {
  // This method is a utility to log messages with a name.
  static void _log(String name, LogLevel level, String message,
      [Object? error, StackTrace? stackTrace]) {
    final loggy = Loggy(name);
    switch (level) {
      case LogLevel.debug:
        loggy.debug(message);
        break;
      case LogLevel.info:
        loggy.info(message);
        break;
      case LogLevel.warning:
        loggy.warning(message);
        break;
      case LogLevel.error:
        loggy.error(message, error, stackTrace);
        break;
    }
  }

  static void debug(String name, String message) {
    _log(name, LogLevel.debug, message);
  }

  static void info(String name, String message) {
    _log(name, LogLevel.info, message);
  }

  static void warning(String name, String message) {
    _log(name, LogLevel.warning, message);
  }

  static void error(String name, String message,
      [Object? error, StackTrace? stackTrace]) {
    _log(name, LogLevel.error, message, error, stackTrace);
    // FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: false);
  }

  static void fatalError(FlutterErrorDetails error) {
    // FirebaseCrashlytics.instance.recordFlutterFatalError(error);
  }

  static Future<void> setUserId(String userId) async {
    // return await FirebaseCrashlytics.instance.setUserIdentifier(userId);
  }
}
