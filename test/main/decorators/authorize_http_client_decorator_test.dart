import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/data/cache/cache.dart';

class AuthorizeHttpClientDecorator {
  final FetchSecureCacheStorage fetchSecureCacheStorage;

  AuthorizeHttpClientDecorator({required this.fetchSecureCacheStorage});

  Future<void> request() async {
    await fetchSecureCacheStorage.fetchSecure('token');
  }
}

class FetchSecureCacheStorageSpy extends Mock
    implements FetchSecureCacheStorage {
  void mockFetchSecure() {
    when(() => fetchSecure(any())).thenAnswer((_) async => 'some_key_value');
  }
}

void main() {
  const tokenKey = 'token';
  late AuthorizeHttpClientDecorator sut;
  late FetchSecureCacheStorageSpy fetchSecureCacheStorage;

  setUp(() {
    fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
    sut = AuthorizeHttpClientDecorator(
      fetchSecureCacheStorage: fetchSecureCacheStorage,
    );
  });

  test('Should call FetchSecureCacheStorage with correct key', () {
    // Arrange
    fetchSecureCacheStorage.mockFetchSecure();
    // Act
    sut.request();
    // Assert
    verify(() => fetchSecureCacheStorage.fetchSecure(tokenKey)).called(1);
  });
}
