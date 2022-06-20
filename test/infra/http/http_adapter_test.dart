import 'dart:convert';
import 'dart:io';

import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/data/http/http.dart';
import 'package:fordev_tdd/infra/http/http.dart';
import 'package:fordev_tdd/infra/mocks/mocks.dart';
import '../mocks/mocks.dart';

void main() {
  const method = 'post';

  late HttpAdapter sut;
  late ClientSpy client;
  late String url;
  late Uri uri;
  late HttpClientBody body;
  late Response response;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
    uri = Uri.parse(url);
    body = ApiFactory.makeValidBody();
    response = HttpFactory.makeResponse(HttpStatus.ok);
  });

  group('POST', () {
    test('Should call post() with correct parameters (url, method, body)',
        () async {
      // Arrange
      //client.mockPost(url);
      when(() => client.post(
            uri,
            headers: HttpAdapter.headers,
            body: jsonEncode(body),
          )).thenAnswer(
        (_) async => HttpFactory.makeResponse(HttpStatus.ok),
      );
      // Act
      await sut.request(url: url, method: method, body: body);
      // Assert
      verify(() => client.post(
            uri,
            headers: HttpAdapter.headers,
            body: jsonEncode(body),
          ));
    });

    test('Should call post() without body', () async {
      // Arrange
      //client.mockPost(url);
      when(() => client.post(
            uri,
            headers: HttpAdapter.headers,
          )).thenAnswer(
        (_) async => HttpFactory.makeResponse(HttpStatus.ok),
      );
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
      //client.mockPost(url);

      when(() => client.post(
            uri,
            headers: HttpAdapter.headers,
          )).thenAnswer(
        (_) async => response,
      );

      when(() => client.post(
            uri,
            headers: HttpAdapter.headers,
          )).thenAnswer(
        (_) async => HttpFactory.makeResponse(HttpStatus.ok),
      );
      // Act
      final sutResponse = await sut.request(url: url, method: method);
      // Assert
      expect(
        sutResponse,
        HttpFactory.makeBody(),
      );
    });
  });
}
