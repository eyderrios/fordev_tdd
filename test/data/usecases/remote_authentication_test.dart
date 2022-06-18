import 'dart:io';

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
  late HttpClientBody body;

  Map<String, dynamic> mockValidData() => {
        'accessToken': faker.guid.guid(),
        'name': faker.person.name(),
      };

  When mockRequest() => when(() => client.request(
        url: url,
        method: method,
        body: body,
      ));

  void mockHttpData(Map<String, dynamic> map) =>
      mockRequest().thenAnswer((_) async => map);

  void mockHttpError(HttpError error) => mockRequest().thenThrow(error);

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
    mockHttpData(mockValidData());
  });

  test('Should call HttpClient with correct URL', () {
    // Arrange

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
    mockHttpError(HttpError.badRequest);

    // Act
    final future = sut.auth(params);

    // Assert
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () {
    // Arrange
    mockHttpError(HttpError.notFound);

    // Act
    final future = sut.auth(params);

    // Assert
    expect(future, throwsA(DomainError.unexpected));
  });
  test('Should throw UnexpectedError if HttpClient returns 500', () {
    // Arrange
    mockHttpError(HttpError.serverError);

    // Act
    final future = sut.auth(params);

    // Assert
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw InvalidCredentialsError if HttpClient returns 401', () {
    // Arrange
    mockHttpError(HttpError.unauthorized);

    // Act
    final future = sut.auth(params);

    // Assert
    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('Should return an Account if HttpClient returns 200', () async {
    // Arrange
    final validData = mockValidData();
    mockHttpData(validData);

    // Act
    final account = await sut.auth(params);

    // Assert
    expect(account.token, validData['accessToken']);
  });

  test(
      'Should throw UnexpectedError if HttpClient returns 200 with invalid data',
      () async {
    // Arrange
    mockHttpData({'invalid_key': 'invalid_value'});

    // Act
    final future = sut.auth(params);

    // Assert
    expect(future, throwsA(DomainError.unexpected));
  });
}
