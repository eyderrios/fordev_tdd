import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/data/cache/cache.dart';

class CacheStorageSpy extends Mock implements CacheStorage {
  void mockFetch({String? key, List<Map>? data}) {
    when(() => fetch(key ?? any())).thenAnswer((_) async => data ?? []);
  }

  void mockFetchError() {
    when(() => fetch(any())).thenThrow(Exception());
  }
}
