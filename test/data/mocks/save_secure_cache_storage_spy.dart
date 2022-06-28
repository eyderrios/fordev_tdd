import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/data/cache/cache.dart';

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {
  void mockSaveSecure() {
    when(() => saveSecure(key: any(named: 'key'), value: any(named: 'value')))
        .thenAnswer((_) => Future<void>(() {}));
  }

  void mockSaveSecureError() {
    when(() => saveSecure(key: any(named: 'key'), value: any(named: 'value')))
        .thenThrow(Exception());
  }
}
