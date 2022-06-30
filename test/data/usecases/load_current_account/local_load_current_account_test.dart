import 'package:faker/faker.dart';
import 'package:fordev_tdd/domain/helpers/domain_error.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/domain/entities/account_entity.dart';
import 'package:fordev_tdd/domain/usecases/usecases.dart';

class LocalLoadCurrentAccount implements LoadCurrentAccount {
  final FetchSecureCacheStorage fetchSecureCacheStorage;

  LocalLoadCurrentAccount({required this.fetchSecureCacheStorage});

  Future<AccountEntity> load() async {
    try {
      final token = await fetchSecureCacheStorage.fetchSecure('token');
      return AccountEntity(token: token);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}

abstract class FetchSecureCacheStorage {
  Future<String> fetchSecure(String key);
}

class FetchSecureCacheStorageSpy extends Mock
    implements FetchSecureCacheStorage {
  When _fetchSecureCall(String? key) => when(() => fetchSecure(key ?? any()));

  void mockFecthSecure({required String? key, required String token}) {
    _fetchSecureCall(key).thenAnswer((_) async => token);
  }

  void mockFecthSecureError({required String? key}) {
    _fetchSecureCall(key).thenThrow(Exception());
  }
}

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
