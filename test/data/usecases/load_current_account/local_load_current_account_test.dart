import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/domain/entities/account_entity.dart';
import 'package:fordev_tdd/domain/usecases/usecases.dart';

class LocalLoadCurrentAccount implements LoadCurrentAccount {
  final FetchSecureCacheStorage fetchSecureCacheStorage;

  LocalLoadCurrentAccount({required this.fetchSecureCacheStorage});

  Future<AccountEntity> load() async {
    final token = await fetchSecureCacheStorage.fetchSecure('token');
    return AccountEntity(token: token);
  }
}

abstract class FetchSecureCacheStorage {
  Future<String> fetchSecure(String key);
}

class FetchSecureCacheStorageSpy extends Mock
    implements FetchSecureCacheStorage {
  void mockFecthSecure({required String? key, required String token}) {
    when(() => fetchSecure(key ?? any())).thenAnswer((_) async => token);
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
}
