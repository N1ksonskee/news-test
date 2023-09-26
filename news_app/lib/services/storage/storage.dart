import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/repositories/storage_repository.dart';

abstract class Storage<T> {
  Future reset();

  Future<T?> read(StorageKey key);

  Future write(StorageKey key, T? value);

  Future delete(StorageKey key);

  Future<bool> compareValue(StorageKey lhsKey, T rhsValue);

  Future<bool> hasValue(StorageKey key);
}

abstract class StorageList extends Storage<List<String>> {
  Future writeOne(StorageKey key, String value);
  Future deleteOne(StorageKey key, String value);
  Future<bool> hasOne(StorageKey key, String value);
}

class OptimisticSingleStorage implements Storage<bool> {
  SharedPreferences? _prefs;

  Future<SharedPreferences> get _initedPrefs async => _prefs ??= await SharedPreferences.getInstance();

  @override
  Future<bool> compareValue(StorageKey lhsKey, bool rhsValue) async {
    return rhsValue == await read(lhsKey);
  }

  @override
  Future delete(StorageKey key) async {
    final store = await _initedPrefs;
    await store.remove(key.name);
  }

  @override
  Future<bool> hasValue(StorageKey key) async {
    final store = await _initedPrefs;
    return store.getBool(key.name) != null;
  }

  @override
  Future<bool?> read(StorageKey key) async {
    final store = await _initedPrefs;
    return store.getBool(key.name);
  }

  @override
  Future reset() async {
    final store = await _initedPrefs;
    await store.clear();
  }

  @override
  Future write(StorageKey key, bool? value) async {
    final store = await _initedPrefs;
    await store.setBool(key.name, value ?? true);
  }
}

class OptimisticMultipleStorage implements StorageList {
  SharedPreferences? _prefs;

  Future<SharedPreferences> get _initedPrefs async => _prefs ??= await SharedPreferences.getInstance();

  @override
  Future<bool> compareValue(StorageKey lhsKey, List<String> rhsValue) async {
    return rhsValue == await read(lhsKey);
  }

  @override
  Future delete(StorageKey key) async {
    final store = await _initedPrefs;
    await store.remove(key.name);
  }

  @override
  Future<bool> hasValue(StorageKey key) async {
    final store = await _initedPrefs;
    final list = store.getStringList(key.name);
    return list != null && list.isNotEmpty;
  }

  @override
  Future<List<String>?> read(StorageKey key) async {
    final store = await _initedPrefs;
    return store.getStringList(key.name);
  }

  @override
  Future reset() async {
    final store = await _initedPrefs;
    await store.clear();
  }

  @override
  Future write(StorageKey key, List<String>? value) async {
    final store = await _initedPrefs;
    await store.setStringList(key.name, value ?? []);
  }

  @override
  Future deleteOne(StorageKey key, String value) async {
    final list = await read(key);
    if (list == null) return;
    list.remove(value);
    await write(key, list);
  }

  @override
  Future<bool> hasOne(StorageKey key, String value) async {
    final list = await read(key);
    if (list == null) {
      return false;
    }
    return list.contains(value);
  }

  @override
  Future writeOne(StorageKey key, String value) async {
    final list = await read(key) ?? [];
    list.add(value);
    await write(key, list);
  }
}
