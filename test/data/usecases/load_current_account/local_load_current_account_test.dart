import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/data/usecases/load_current_account/load_current_account.dart';
import 'package:fordev_tdd/domain/entities/account_entity.dart';
import 'package:fordev_tdd/domain/helpers/domain_error.dart';

import '../../mocks/mocks.dart';

void main() {
  late FetchSecureCacheStorageSpy fetchSecureCacheStorage;
  late LocalLoadCurrentAccount sut;
  late String token;

  setUp(() {
    token = faker.guid.guid();
    fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
    sut = LocalLoadCurrentAccount(
        fetchSecureCacheStorage: fetchSecureCacheStorage);
  });

  test('Should call FetchSecureCacheStorage with correct parameter', () async {
    // Arrange
    fetchSecureCacheStorage.mockFecthSecure(key: null, token: token);
    // Act
    await sut.load();
    // Assert
    verify(() => fetchSecureCacheStorage.fetchSecure('token')).called(1);
  });

  test('Should return an AccountEntity', () async {
    // Arrange
    fetchSecureCacheStorage.mockFecthSecure(key: null, token: token);
    // Act
    final account = await sut.load();
    // Assert
    expect(account, AccountEntity(token: token));
  });

  test('Should throw UnexpectedError if FetchSecureCacheStorage throws',
      () async {
    // Arrange
    fetchSecureCacheStorage.mockFecthSecureError(key: null);
    // Act
    final future = sut.load();
    // Assert
    expect(future, throwsA(DomainError.unexpected));
  });
}
