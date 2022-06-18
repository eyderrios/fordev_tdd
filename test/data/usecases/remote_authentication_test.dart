import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/domain/helpers/helpers.dart';
import 'package:fordev_tdd/domain/usecases/usecases.dart';

import 'package:fordev_tdd/data/usecases/usecases.dart';
import 'package:fordev_tdd/data/http/http.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  const String method = 'post';
  late String url;
  late HttpClientSpy client;
  late RemoteAuthentication sut;
  late AuthenticationParams params;
  late Map<String, dynamic> body;

  setUp(() {
    url = faker.internet.httpUrl();
    client = HttpClientSpy();
    sut = RemoteAuthentication(httpClient: client, url: url);
    params = AuthenticationParams(
      email: faker.internet.email(),
      password: faker.internet.password(),
    );
    body = {
      'email': params.email,
      'password': params.password,
    };
  });

  test('Should call HttpClient with correct URL', () {
    // Arrange
    when(() => client.request(
          url: url,
          method: method,
          body: body,
        )).thenAnswer((_) async => {
          'accessToken': faker.guid.guid(),
          'name': faker.person.name(),
        });

    // Act
    sut.auth(params);

    // Assert
    verify(() => client.request(
          url: url,
          method: 'post',
          body: body,
        )).called(1);
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () {
    // Arrange
    when(() => client.request(
          url: any(named: 'url'),
          method: any(named: 'method'),
          body: any(named: 'body'),
        )).thenThrow(HttpError.badRequest);

    // Act
    final future = sut.auth(params);

    // Assert
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () {
    // Arrange
    when(() => client.request(
          url: any(named: 'url'),
          method: any(named: 'method'),
          body: any(named: 'body'),
        )).thenThrow(HttpError.notFound);

    // Act
    final future = sut.auth(params);

    // Assert
    expect(future, throwsA(DomainError.unexpected));
  });
  test('Should throw UnexpectedError if HttpClient returns 500', () {
    // Arrange
    when(() => client.request(
          url: any(named: 'url'),
          method: any(named: 'method'),
          body: any(named: 'body'),
        )).thenThrow(HttpError.serverError);

    // Act
    final future = sut.auth(params);

    // Assert
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw InvalidCredentialsError if HttpClient returns 401', () {
    // Arrange
    when(() => client.request(
          url: any(named: 'url'),
          method: any(named: 'method'),
          body: any(named: 'body'),
        )).thenThrow(HttpError.unauthorized);

    // Act
    final future = sut.auth(params);

    // Assert
    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('Should return an Account if HttpClient returns 200', () async {
    // Arrange
    final String token = faker.guid.guid();
    final Map<String, dynamic> response = {
      'accessToken': token,
      'name': faker.person.name(),
    };

    when(() => client.request(
          url: any(named: 'url'),
          method: any(named: 'method'),
          body: any(named: 'body'),
        )).thenAnswer((_) async => response);

    // Act
    final account = await sut.auth(params);

    // Assert
    expect(account.token, token);
  });

  test(
      'Should throw UnexpectedError if HttpClient returns 200 with invalid data',
      () async {
    // Arrange
    when(() => client.request(
          url: any(named: 'url'),
          method: any(named: 'method'),
          body: any(named: 'body'),
        )).thenAnswer((_) async => {'invalid_key': 'invalid_value'});

    // Act
    final future = sut.auth(params);

    // Assert
    expect(future, throwsA(DomainError.unexpected));
  });
}
