import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/data/cache/cache.dart';

class FetchSecureCacheStorageSpy extends Mock
    implements FetchSecureCacheStorage {
  When _fetchSecureCall(String? key) => when(() => fetchSecure(key ?? any()));

  void mockFetchSecure({required String? key, required String token}) {
    _fetchSecureCall(key).thenAnswer((_) async => token);
  }

  void mockFetchSecureError({required String? key}) {
    _fetchSecureCall(key).thenThrow(Exception());
  }
}
