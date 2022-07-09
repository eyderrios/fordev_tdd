import 'package:faker/faker.dart';
import 'package:fordev_tdd/main/factories/http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/data/cache/cache.dart';
import 'package:fordev_tdd/data/http/http.dart';

class AuthorizeHttpClientDecorator {
  final FetchSecureCacheStorage fetchSecureCacheStorage;

  AuthorizeHttpClientDecorator({required this.fetchSecureCacheStorage});

  Future<void> request({
    required String url,
    required String method,
    HttpClientBody? body,
    HttpClientHeaders? headers,
  }) async {
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
  late String url;
  late String method;
  late HttpClientBody body;

  setUp(() {
    fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
    sut = AuthorizeHttpClientDecorator(
      fetchSecureCacheStorage: fetchSecureCacheStorage,
    );
    url = faker.internet.httpUrl();
    method = faker.randomGenerator.string(10);
    body = {'some_key': 'some_value'};
  });

  test('Should call FetchSecureCacheStorage with correct key', () {
    // Arrange
    fetchSecureCacheStorage.mockFetchSecure();
    // Act
    sut.request(url: url, method: method, body: body);
    // Assert
    verify(() => fetchSecureCacheStorage.fetchSecure(tokenKey)).called(1);
  });
}
