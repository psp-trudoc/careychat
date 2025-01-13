import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppPreferenceService {
  SharedPreferences? _prefs;

  static AppPreferenceService? _instance;

  AppPreferenceService._internal() {
    initialize();
  }

  factory AppPreferenceService() {
    _instance ??= AppPreferenceService._internal();
    return _instance!;
  }

  SharedPreferences? get _initializePrefs {
    return _prefs;
  }

  void initialize() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  void setBool(String key, bool value) {
    _initializePrefs?.setBool(key, value);
  }

  int getInt(String key) {
    return _initializePrefs?.getInt(key) ?? 0;
  }

  bool getBool(String key) {
    return _initializePrefs?.getBool(key) ?? false;
  }

  void setInt(String key, int value) {
    _initializePrefs?.setInt(key, value);
  }

  String getString(String key) {
    return _initializePrefs?.getString(key) ?? '';
  }

  void setString(String key, String value) {
    _initializePrefs?.setString(key, value);
  }

  double getDouble(String key) {
    return _initializePrefs?.getDouble(key) ?? 0.0;
  }

  void setDouble(String key, double value) {
    _initializePrefs?.setDouble(key, value);
  }

  void saveStringList(String key, List<String> value) {
    _initializePrefs?.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    return _initializePrefs?.getStringList(key);
  }

  Future<bool?> saveJsonObject(
      String key, Map<String, dynamic> jsonObject) async {
    String jsonString = json.encode(jsonObject);
    return _initializePrefs?.setString(key, jsonString);
  }

  Map<String, dynamic> getJsonObject(String key) {
    String? jsonString = _initializePrefs?.getString(key);
    if (jsonString != null) {
      return json.decode(jsonString);
    }
    return {};
  }

  void removeKey(String key) {
    _initializePrefs?.remove(key);
  }

  // Clearing all data from SharedPreferences
  void clearAllData() {
    _initializePrefs?.clear();
  }
}
