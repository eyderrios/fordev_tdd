import 'dart:convert';
import 'dart:io';

import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/data/http/http.dart';
import 'package:fordev_tdd/infra/http/http.dart';
import 'package:fordev_tdd/infra/mocks/mocks.dart';
import '../mocks/mocks.dart';

void main() {
  const method = 'post';

  late String url;
  late HttpAdapter sut;
  late ClientSpy client;
  late String jsonBody;
  late HttpClientBody mapBody;

  setUp(() {
    url = faker.internet.httpUrl();
    client = ClientSpy();
    sut = HttpAdapter(client);
    jsonBody = HttpFactory.makeBody();
    mapBody = jsonDecode(jsonBody);
  });

  group('COMMON', () {
    test('Should throw ServerError if invalid method is provided', () async {
      // Arrange
      client.mockResponse(HttpStatus.ok, jsonBody);
      // Act
      final future = sut.request(url: url, method: 'invalid_method');
      // Assert
      expect(future, throwsA(HttpError.serverError));
    });
  });

  group('POST', () {
    test('Should call post() with correct parameters (url, method, body)',
        () async {
      // Arrange
      client.mockResponse(HttpStatus.ok, jsonBody);
      // Act
      await sut.request(url: url, method: method, body: mapBody);
      // Assert
      verify(() => client.post(
            Uri.parse(url),
            headers: HttpAdapter.headers,
            body: jsonBody,
          ));
    });

    test('Should call post() without body', () async {
      // Arrange
      client.mockResponse(HttpStatus.ok, '');
      // Act
      await sut.request(url: url, method: method);
      // Assert
      verify(() => client.post(
            Uri.parse(url),
            headers: any(named: 'headers'),
          ));
    });

    test('Should return data if post() returns 200', () async {
      // Arrange
      client.mockResponse(HttpStatus.ok, jsonBody);
      // Act
      final sutResponse = await sut.request(url: url, method: method);
      // Assert
      expect(sutResponse, mapBody);
    });

    test('Should return null if post() returns 200 with no data', () async {
      // Arrange
      client.mockResponse(HttpStatus.ok, '');
      // Act
      final sutResponse = await sut.request(url: url, method: method);
      // Assert
      expect(sutResponse, null);
    });

    test('Should return null if post() returns 204', () async {
      // Arrange
      client.mockResponse(HttpStatus.noContent, '');
      // Act
      final sutResponse = await sut.request(url: url, method: method);
      // Assert
      expect(sutResponse, null);
    });

    test('Should return null if post() returns 204 with data', () async {
      // Arrange
      client.mockResponse(HttpStatus.noContent, jsonBody);
      // Act
      final sutResponse = await sut.request(url: url, method: method);
      // Assert
      expect(sutResponse, null);
    });

    test('Should return BadRequestError if post() returns 400 with no body',
        () async {
      // Arrange
      client.mockResponse(HttpStatus.badRequest, '');
      // Act
      final future = sut.request(url: url, method: method);
      // Assert
      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return BadRequestError if post() returns 400', () async {
      // Arrange
      client.mockResponse(HttpStatus.badRequest, jsonBody);
      // Act
      final future = sut.request(url: url, method: method);
      // Assert
      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return BadRequestError if post() returns 401', () async {
      // Arrange
      client.mockResponse(HttpStatus.unauthorized, jsonBody);
      // Act
      final future = sut.request(url: url, method: method);
      // Assert
      expect(future, throwsA(HttpError.unauthorized));
    });

    test('Should return ForbiddenError if post() returns 403', () async {
      // Arrange
      client.mockResponse(HttpStatus.forbidden, jsonBody);
      // Act
      final future = sut.request(url: url, method: method);
      // Assert
      expect(future, throwsA(HttpError.forbidden));
    });

    test('Should return NotFoundError if post() returns 404', () async {
      // Arrange
      client.mockResponse(HttpStatus.notFound, jsonBody);
      // Act
      final future = sut.request(url: url, method: method);
      // Assert
      expect(future, throwsA(HttpError.notFound));
    });

    test('Should return ServerError if post() returns 500', () async {
      // Arrange
      client.mockResponse(HttpStatus.internalServerError, jsonBody);
      // Act
      final future = sut.request(url: url, method: method);
      // Assert
      expect(future, throwsA(HttpError.serverError));
    });

    test('Should return ServerError if post() throws', () async {
      // Arrange
      client.mockError();
      // Act
      final future = sut.request(url: url, method: method);
      // Assert
      expect(future, throwsA(HttpError.serverError));
    });
  });
}
