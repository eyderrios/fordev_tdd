import 'package:faker/faker.dart';
import 'package:fordev_tdd/domain/helpers/domain_error.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/domain/entities/entities.dart';
import 'package:fordev_tdd/domain/usecases/usecases.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount {
  final SaveSecureCacheStorage saveSecureCacheStorage;

  LocalSaveCurrentAccount({required this.saveSecureCacheStorage});

  @override
  Future<void> save(AccountEntity account) async {
    try {
      await saveSecureCacheStorage.saveSecure(
        key: 'token',
        value: account.token,
      );
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}

abstract class SaveSecureCacheStorage {
  Future<void> saveSecure({required String key, required String value});
}

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

void main() {
  late AccountEntity account;
  late SaveSecureCacheStorageSpy cache;
  late LocalSaveCurrentAccount sut;

  setUp(() {
    cache = SaveSecureCacheStorageSpy();
    sut = LocalSaveCurrentAccount(saveSecureCacheStorage: cache);
    account = AccountEntity(token: faker.guid.guid());
  });

  test('Should call SaveCacheStorage with correct params', () async {
    // Arrange
    cache.mockSaveSecure();
    // Act
    await sut.save(account);
    // Assert
    verify(() => cache.saveSecure(key: 'token', value: account.token));
  });

  test('Should throws UnexpectedError if SaveSecureCacheStorage throws',
      () async {
    // Arrange
    cache.mockSaveSecureError();
    // Act
    final future = sut.save(account);
    // Assert
    expect(future, throwsA(DomainError.unexpected));
  });
}
