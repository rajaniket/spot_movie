import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageService {
  /// Removes the value associated with the given [key].
  Future<bool> remove(String key);

  /// Retrieves the value associated with the given [key], returning [defaultValue] if it doesn't exist.
  Future<T?> get<T>(String key, [T? defaultValue]);

  /// Sets the value associated with the given [key].
  Future<void> set(String key, Object? value);

  /// Clears all key-value pairs from the storage.
  Future<void> clear();

  /// Checks if a value exists for the given [key].
  Future<bool> has(String key);
}

/// Module for providing shared preferences instance
@module
abstract class SharedPreferencesModule {
  @preResolve
  Future<SharedPreferences> get prefs async => SharedPreferences.getInstance();
}

/// Implementation of the StorageService interface using SharedPreferences.
@Injectable(as: StorageService)
class SharedPreferencesStorageService implements StorageService {
  const SharedPreferencesStorageService(this._sharedPrefs);

  final SharedPreferences _sharedPrefs;

  @override
  Future<bool> remove(String key) async {
    return _sharedPrefs.remove(key);
  }

  @override
  Future<T?> get<T>(String key, [T? defaultValue]) async {
    if (_sharedPrefs.containsKey(key)) {
      return _sharedPrefs.get(key) as T?;
    }
    return defaultValue;
  }

  @override
  Future<void> set(String key, Object? value) async {
    if (value is String) {
      await _sharedPrefs.setString(key, value);
    } else if (value is int) {
      await _sharedPrefs.setInt(key, value);
    } else if (value is double) {
      await _sharedPrefs.setDouble(key, value);
    } else if (value is bool) {
      await _sharedPrefs.setBool(key, value);
    } else if (value is List<String>) {
      await _sharedPrefs.setStringList(key, value);
    } else {
      throw Exception('Invalid type for SharedPreferences storage');
    }
  }

  @override
  Future<void> clear() async {
    await _sharedPrefs.clear();
  }

  @override
  Future<bool> has(String key) async {
    return _sharedPrefs.containsKey(key);
  }
}
