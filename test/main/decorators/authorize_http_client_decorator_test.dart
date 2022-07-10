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
    HttpClientHeaders authHeaders = {};
    if (token != null) {
      authHeaders.addAll({'x-access-token': token});
    }
    if (headers != null) {
      authHeaders.addAll(headers);
    }
    return await decoratee.request(
      url: url,
      method: method,
      body: body,
      headers: authHeaders.isNotEmpty ? authHeaders : null,
    );
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
  late HttpClientHeaders someHeader;
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
    someHeader = {'some_header_key': 'some_header_value'};
  });

  test('Should call FetchSecureCacheStorage with correct key', () async {
    // Arrange
    cache.mockFetchSecure(tokenValue);
    client.mockRequest({});
    // Act
    await sut.request(url: url, method: method, body: body);
    // Assert
    verify(() => cache.fetchSecure(tokenKey)).called(1);
  });

  test('Should call decoratee with access token on header', () async {
    //
    // DECORATEE: the class that is being decorated
    //
    // Arrange
    cache.mockFetchSecure(tokenValue);
    client.mockRequest({});
    // Act
    await sut.request(url: url, method: method, body: body);
    // Assert
    verify(() => client.request(
          url: url,
          method: method,
          body: body,
          headers: tokenHeader,
        )).called(1);

    // Assert
    final HttpClientHeaders expectedHeaders = Map.from(tokenHeader);
    expectedHeaders.addAll(someHeader);
    // Act
    await sut.request(
        url: url, method: method, body: body, headers: someHeader);
    // Assert
    verify(() => client.request(
          url: url,
          method: method,
          body: body,
          headers: expectedHeaders,
        )).called(1);
  });

  test('Should return same result than decoratee', () async {
    // Arrange
    cache.mockFetchSecure(tokenValue);
    client.mockRequest(body);
    // Act
    final response = await sut.request(url: url, method: method, body: body);
    // Assert
    expect(response, body);
  });
}
