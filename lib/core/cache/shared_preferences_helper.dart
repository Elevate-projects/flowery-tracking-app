import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class SharedPreferencesHelper {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesHelper(this._sharedPreferences);

  Future<void> removeData({required String key}) async {
    await _sharedPreferences.remove(key);
  }

  Future<void> clearAllData() async {
    await _sharedPreferences.clear();
  }

  Future<void> saveDouble({required String key, required double value}) async {
    _log("setDouble | key: $key | value: $value");
    await _sharedPreferences.setDouble(key, value);
  }

  Future<void> saveInt({required String key, required int value}) async {
    _log("setInt | key: $key | value: $value");
    await _sharedPreferences.setInt(key, value);
  }

  Future<void> saveString({required String key, required String value}) async {
    _log("setString | key: $key | value: $value");
    await _sharedPreferences.setString(key, value);
  }

  Future<void> saveBool({required String key, required bool value}) async {
    _log("setBool | key: $key | value: $value");
    await _sharedPreferences.setBool(key, value);
  }

  Future<void> saveStringList({
    required String key,
    required List<String> value,
  }) async {
    _log("setStringList | key: $key | value: $value");
    await _sharedPreferences.setStringList(key, value);
  }

  List<String> getStringList({required String key}) {
    _log("getStringList | key: $key");
    return _sharedPreferences.getStringList(key) ?? [];
  }

  bool getBool({required String key}) {
    _log("getBool | key: $key");
    return _sharedPreferences.getBool(key) ?? false;
  }

  double getDouble({required String key}) {
    _log("getDouble | key: $key");
    return _sharedPreferences.getDouble(key) ?? 0.0;
  }

  int getInt({required String key}) {
    _log("getInt | key: $key");
    return _sharedPreferences.getInt(key) ?? 0;
  }

  String getString({required String key}) {
    _log("getString | key: $key");
    return _sharedPreferences.getString(key) ?? '';
  }

  void _log(String message) {
    assert(() {
      debugPrint("SharedPrefHelper: $message");
      return true;
    }());
  }
}
