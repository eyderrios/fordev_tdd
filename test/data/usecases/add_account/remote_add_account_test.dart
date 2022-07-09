import 'package:faker/faker.dart';
import 'package:fordev_tdd/domain/helpers/helpers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/domain/usecases/usecases.dart';
import 'package:fordev_tdd/data/usecases/usecases.dart';
import 'package:fordev_tdd/data/http/http.dart';

import '../../../domain/mocks/mocks.dart';
import '../../../infra/mocks/mocks.dart';
import '../../mocks/mocks.dart';

void main() {
  late String url;
  late HttpClientSpy<RemoteAddAccountResponse> client;
  late RemoteAddAccount sut;
  late AddAccountParams params;
  late HttpClientBody body;
  late HttpClientBody bodyToken;

  setUp(() {
    url = faker.internet.httpUrl();
    client = HttpClientSpy();
    sut = RemoteAddAccount(httpClient: client, url: url);
    params = ParamsFactory.makeAddAccountParams();
    body = {
      'name': params.name,
      'email': params.email,
      'password': params.password,
      'passwordConfirmation': params.passwordConfirmation,
    };
    bodyToken = {
      'accessToken': faker.guid.guid(),
    };
  });

  test('Should call HttpClient with correct URL', () {
    // Arrange
    client.mockRequest(bodyToken);
    // Act
    sut.add(params);
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
    final future = sut.add(params);
    // Assert
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () {
    // Arrange
    client.mockRequestError(HttpError.notFound);
    // Act
    final future = sut.add(params);
    // Assert
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () {
    // Arrange
    client.mockRequestError(HttpError.serverError);
    // Act
    final future = sut.add(params);
    // Assert
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw InvalidCredentialsError if HttpClient returns 403', () {
    // Arrange
    client.mockRequestError(HttpError.forbidden);
    // Act
    final future = sut.add(params);
    // Assert
    expect(future, throwsA(DomainError.emailInUse));
  });

  test('Should return an Account if HttpClient returns 200', () async {
    // Arrange
    client.mockRequest(bodyToken);
    // Act
    final account = await sut.add(params);
    // Assert
    expect(account.token, bodyToken['accessToken']);
  });

  test(
      'Should throw UnexpectedError if HttpClient returns 200 with invalid data',
      () async {
    // Arrange
    client.mockRequest(ApiFactory.makeInvalidBody());
    // Act
    final future = sut.add(params);
    // Assert
    expect(future, throwsA(DomainError.unexpected));
  });
}
