import 'package:faker/faker.dart';
import 'package:fordev_tdd/main/decorators/decorators.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/data/http/http.dart';

import '../../data/mocks/mocks.dart';

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
    cache.mockFetchSecure(key: null, token: tokenValue);
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
    cache.mockFetchSecure(key: null, token: tokenValue);
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
    cache.mockFetchSecure(key: null, token: tokenValue);
    client.mockRequest(body);
    // Act
    final response = await sut.request(url: url, method: method, body: body);
    // Assert
    expect(response, body);
  });

  test('Should throw ForbidenError if FetchSecureCacheStorage throws',
      () async {
    // Arrange
    client.mockRequest(body);
    cache.mockFetchSecureError(key: null);
    // Act
    final future = sut.request(url: url, method: method, body: body);
    // Assert
    expect(future, throwsA(HttpError.forbidden));
  });

  test('Should rethrow if decoratee throws', () async {
    // Arrange
    cache.mockFetchSecure(key: null, token: tokenValue);
    client.mockRequestError(HttpError.badRequest);
    // Act
    final future = sut.request(url: url, method: method, body: body);
    // Assert
    expect(future, throwsA(HttpError.badRequest));
  });
}
