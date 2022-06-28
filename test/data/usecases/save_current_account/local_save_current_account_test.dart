import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/data/usecases/save_current_account/save_current_account.dart';
import 'package:fordev_tdd/domain/helpers/domain_error.dart';
import 'package:fordev_tdd/domain/entities/entities.dart';

import '../../mocks/save_secure_cache_storage_spy.dart';

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
