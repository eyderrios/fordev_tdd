import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/domain/helpers/helpers.dart';
import 'package:fordev_tdd/domain/usecases/usecases.dart';

import 'package:fordev_tdd/data/usecases/usecases.dart';
import 'package:fordev_tdd/data/http/http.dart';

import '../../../domain/mocks/mocks.dart';
import '../../../infra/mocks/mocks.dart';
import '../../mocks/mocks.dart';

void main() {
  late String url;
  late HttpClientSpy client;
  late RemoteAuthentication sut;
  late AuthenticationParams params;
  late HttpClientBody body;

  setUp(() {
    url = faker.internet.httpUrl();
    client = HttpClientSpy();
    sut = RemoteAuthentication(httpClient: client, url: url);
    params = ParamsFactory.makeAuthenticationParams();
    body = {
      'email': params.email,
      'password': params.password,
    };
    client.mockRequest(ApiFactory.makeAccountBody());
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
    client.mockRequestError(HttpError.badRequest);
    // Act
    final future = sut.auth(params);
    // Assert
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () {
    // Arrange
    client.mockRequestError(HttpError.notFound);
    // Act
    final future = sut.auth(params);
    // Assert
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () {
    // Arrange
    client.mockRequestError(HttpError.serverError);
    // Act
    final future = sut.auth(params);
    // Assert
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw InvalidCredentialsError if HttpClient returns 401', () {
    // Arrange
    client.mockRequestError(HttpError.unauthorized);
    // Act
    final future = sut.auth(params);
    // Assert
    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('Should return an Account if HttpClient returns 200', () async {
    // Arrange
    final validData = ApiFactory.makeAccountBody();
    client.mockRequest(validData);
    // Act
    final account = await sut.auth(params);
    // Assert
    expect(account.token, validData['accessToken']);
  });

  test(
      'Should throw UnexpectedError if HttpClient returns 200 with invalid data',
      () async {
    // Arrange
    client.mockRequest(ApiFactory.makeInvalidBody());
    // Act
    final future = sut.auth(params);
    // Assert
    expect(future, throwsA(DomainError.unexpected));
  });
}
