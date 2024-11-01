import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageService {
  Future<bool> remove(String key);
  Future<T?> get<T>(String key, [T? defaultValue]);
  Future<void> set(String key, Object? value);
  Future<void> clear();
  Future<bool> has(String key);
}

class SharedPreferencesStorageService implements StorageService {
  late final SharedPreferences _prefs;
  bool _isInitialized = false;

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    _isInitialized = true;
  }

  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await _init();
    }
  }

  @override
  Future<bool> remove(String key) async {
    await _ensureInitialized();
    return _prefs.remove(key);
  }

  @override
  Future<T?> get<T>(String key, [T? defaultValue]) async {
    await _ensureInitialized();
    if (_prefs.containsKey(key)) {
      return _prefs.get(key) as T?;
    }
    return defaultValue;
  }

  @override
  Future<void> set(String key, Object? value) async {
    await _ensureInitialized();
    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is List<String>) {
      await _prefs.setStringList(key, value);
    } else {
      throw Exception('Invalid type for SharedPreferences storage');
    }
  }

  @override
  Future<void> clear() async {
    await _ensureInitialized();
    await _prefs.clear();
  }

  @override
  Future<bool> has(String key) async {
    await _ensureInitialized();
    return _prefs.containsKey(key);
  }
}
