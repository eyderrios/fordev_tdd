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

    test('Should return BadRequestError if post() returns 400', () async {
      // Arrange
      client.mockResponse(HttpStatus.badRequest, jsonBody);
      // Act
      final future = sut.request(url: url, method: method);
      // Assert
      expect(future, throwsA(HttpError.badRequest));
    });
  });
}
