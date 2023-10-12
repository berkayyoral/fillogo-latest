import 'dart:developer';
import 'package:fillogo/core/init/secure_manager/secure_manager.dart';
import 'package:fillogo/export.dart';


class LocaleManager {
  static final LocaleManager _instance = LocaleManager._init();
  static LocaleManager get instance => _instance;
  late final SharedPreferences _preferences;

  LocaleManager._init();

  Future<void> preferencesInit() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> setCryptedData(PreferencesKeys key, dynamic value) async {
    final String temp = SecureManager().encryp(value);
    await _preferences.setString(key.toString(), temp);
  }

  Future<void> setString(PreferencesKeys key, String value) async {
    await _preferences.setString(key.toString(), value);
  }

  Future<void> setBool(PreferencesKeys key, bool value) async {
    await _preferences.setBool(key.toString(), value);
  }

  Future<void> setInt(PreferencesKeys key, int value) async {
    await _preferences.setInt(key.toString(), value);
  }

  String? getString(PreferencesKeys key) {
    try {
      String? value = _preferences.getString(key.toString());
      return value;
    } catch (e) {
      return null;
    }
  }

  int? getInt(PreferencesKeys key) {
    try {
      int? value = _preferences.getInt(key.toString());
      return value;
    } catch (e) {
      return null;
    }
  }

  bool? getBool(PreferencesKeys key) {
    try {
      bool? value = _preferences.getBool(key.toString());
      return value;
    } catch (e) {
      return null;
    }
  }

  String? getCryptedData(PreferencesKeys key) {
    try {
      String? value = _preferences.getString(key.toString());
      if (value != null) value = SecureManager().decryp(value);
      return value;
    } on Exception catch (e) {
      log('getCryptedData error = $e');
      return null;
    }
  }

  Future<void> remove(PreferencesKeys key) async {
    await _preferences.remove(key.toString());
  }

  Future<void> clear() async {
    await _preferences.clear();
  }
}
