import 'package:fordev_tdd/data/cache/cache.dart';
import 'package:localstorage/localstorage.dart';

class LocalStorageAdapter implements CacheStorage {
  LocalStorage localStorage;

  LocalStorageAdapter({
    required this.localStorage,
  });

  @override
  Future<void> save({required String key, required dynamic value}) async {
    await localStorage.deleteItem(key);
    await localStorage.setItem(key, value);
    return Future<void>(() {});
  }

  @override
  Future<void> delete(String key) async {
    await localStorage.deleteItem(key);
    return Future<void>(() {});
  }

  @override
  Future<dynamic> fetch(String key) async {
    return localStorage.getItem(key);
  }
}
