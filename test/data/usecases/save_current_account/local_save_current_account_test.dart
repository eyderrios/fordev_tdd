import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/domain/entities/entities.dart';
import 'package:fordev_tdd/domain/usecases/usecases.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount {
  final SaveSecureCacheStorage saveSecureCacheStorage;

  LocalSaveCurrentAccount({required this.saveSecureCacheStorage});

  @override
  Future<void> save(AccountEntity account) async {
    await saveSecureCacheStorage.saveSecure(key: 'token', value: account.token);
  }
}

abstract class SaveSecureCacheStorage {
  Future<void> saveSecure({required String key, required String value});
}

class SaveCacheStorageSpy extends Mock implements SaveSecureCacheStorage {
  void mockSaveSecure() {
    when(() => saveSecure(key: any(named: 'key'), value: any(named: 'value')))
        .thenAnswer((_) => Future<void>(() {}));
  }
}

void main() {
  test('Should call SaveCacheStorage with correct params', () async {
    final cache = SaveCacheStorageSpy();
    final sut = LocalSaveCurrentAccount(saveSecureCacheStorage: cache);
    final account = AccountEntity(token: faker.guid.guid());

    // Arrange
    cache.mockSaveSecure();
    // Act
    await sut.save(account);
    // Assert
    verify(() => cache.saveSecure(key: 'token', value: account.token));
  });
}
