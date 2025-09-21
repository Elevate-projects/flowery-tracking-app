import 'dart:developer';

import 'package:flowery_tracking_app/core/constants/const_keys.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class SecureStorage {
  final FlutterSecureStorage storage;

  SecureStorage()
    : storage = const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
      );

  Future<void> saveData({required String key, required String value}) async {
    try {
      await storage.write(key: key, value: value);
    } catch (e) {
      log('SecureStorage error: $e');
      await storage.deleteAll();
      await storage.write(key: key, value: value);
    }
  }

  Future<void> saveUserToken({required String? token}) async {
    await saveData(key: ConstKeys.tokenKey, value: token ?? "");
  }

  Future<String?> getData({required String key}) async {
    return await storage.read(key: key);
  }

  Future<void> deleteData({required String key}) async {
    await storage.delete(key: key);
  }
}
