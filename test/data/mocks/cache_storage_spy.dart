import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/data/cache/cache.dart';

class CacheStorageSpy extends Mock implements CacheStorage {
  void mockFetch({String? key, List<Map>? data}) {
    when(() => fetch(key ?? any())).thenAnswer((_) async => data ?? []);
  }

  void mockFetchError() {
    when(() => fetch(any())).thenThrow(Exception());
  }

  void mockDelete({String? key}) {
    when(() => delete(key ?? any())).thenAnswer((_) async => _);
  }

  When _mockSaveCall({String? key, dynamic value}) {
    return when(() => save(
        key: key ?? any(named: 'key'), value: value ?? any(named: 'value')));
  }

  void mockSave({String? key, dynamic value}) {
    _mockSaveCall(key: key, value: value).thenAnswer((_) async => _);
  }

  void mockSaveError() {
    _mockSaveCall().thenThrow(Exception());
  }
}
