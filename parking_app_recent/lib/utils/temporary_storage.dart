import 'dart:developer';

// import 'package:get_storage/get_storage.dart';
import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageManager {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance!;
  }

  static String getString({required dynamic key}) {
    return _prefsInstance?.getString(key) ?? "";
  }

  static Future<bool> setString(
      {required String key, required dynamic value}) async {
    var prefs = await _instance;
    return prefs.setString(key, value!);
  }

  static Future<bool> setBool(
      {required String key, required bool? value}) async {
    var prefs = await _instance;
    return prefs.setBool(key, value!);
  }

  static Future<bool> getBool({required dynamic key}) async {
    var prefs = await _instance;
    return prefs.getBool(key) ?? false;
  }

  static int getInt({required String key}) {
    return _prefsInstance!.getInt(key) ?? 0;
  }

  static Future setInt({required String key, required int value}) async {
    var prefs = await _instance;
    return prefs.setInt(key, value);
  }

    static Future eraseData({required String key}) async {
    var prefs = await _instance;
    return prefs.remove(key);
  }

  static Future eraseAllData() async {
    var prefs = await _instance;
    var storedData = await SharedPreferences.getInstance();
    storedData.clear();
    log('All stored data cleared');
    return prefs.clear();
  }
}
