import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/data/cache/cache.dart';
import 'package:fordev_tdd/data/http/http.dart';

class AuthorizeHttpClientDecorator<ResponseType> {
  final FetchSecureCacheStorage fetchSecureCacheStorage;
  final HttpClient<ResponseType> decoratee;

  AuthorizeHttpClientDecorator({
    required this.fetchSecureCacheStorage,
    required this.decoratee,
  });

  Future<ResponseType?> request({
    required String url,
    required String method,
    HttpClientBody? body,
    HttpClientHeaders? headers,
  }) async {
    final token = await fetchSecureCacheStorage.fetchSecure('token');
    HttpClientHeaders authHeaders = {'x-access-token': token ?? ''};
    final response = await decoratee.request(
      url: url,
      method: method,
      body: body,
      headers: authHeaders,
    );
    return response;
  }
}

class FetchSecureCacheStorageSpy extends Mock
    implements FetchSecureCacheStorage {
  void mockFetchSecure(String token) {
    when(() => fetchSecure(any())).thenAnswer((_) async => token);
  }
}

class HttpClientSpy<ResponseType> extends Mock
    implements HttpClient<ResponseType> {
  void mockRequest(ResponseType response) {
    when(() => request(
          url: any(named: 'url'),
          method: any(named: 'method'),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        )).thenAnswer((_) async => response);
  }
}

void main() {
  late AuthorizeHttpClientDecorator<HttpClientBody> sut;
  late HttpClientSpy<HttpClientBody> client;
  late FetchSecureCacheStorageSpy cache;
  late String url;
  late String method;
  late HttpClientBody body;
  late HttpClientHeaders tokenHeader;
  late String tokenValue;
  const tokenKey = 'token';

  setUp(() {
    cache = FetchSecureCacheStorageSpy();
    client = HttpClientSpy();
    sut = AuthorizeHttpClientDecorator(
      fetchSecureCacheStorage: cache,
      decoratee: client,
    );
    url = faker.internet.httpUrl();
    method = faker.randomGenerator.string(10);
    body = {'some_key': 'some_value'};
    tokenValue = faker.guid.guid();
    tokenHeader = {'x-access-token': tokenValue};
  });

  test('Should call FetchSecureCacheStorage with correct key', () {
    // Arrange
    cache.mockFetchSecure(tokenValue);
    client.mockRequest({});
    // Act
    sut.request(url: url, method: method, body: body);
    // Assert
    verify(() => cache.fetchSecure(tokenKey)).called(1);
  });

  test('Should call decoratee with access token on header', () {
    //
    // DECORATEE: the class that is being decorated
    //
    // Arrange
    cache.mockFetchSecure(tokenValue);
    client.mockRequest({});
    // Act
    sut.request(url: url, method: method, body: body);
    // Assert
    verify(() => client.request(
          url: url,
          method: method,
          body: body,
          headers: tokenHeader,
        )).called(1);
  });
}
