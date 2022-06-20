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

  late HttpAdapter sut;
  late ClientSpy client;
  late String url;
  late HttpClientBody body;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
    body = ApiFactory.makeValidBody();
  });

  group('POST', () {
    test('Should call post() with correct parameters (url, method, body)',
        () async {
      // Arrange
      client = ClientSpy();
      sut = HttpAdapter(client);
      //client.mockPost(url);
      when(() => client.post(
            Uri.parse(url),
            headers: HttpAdapter.headers,
            body: jsonEncode(body),
          )).thenAnswer(
        (_) async => HttpFactory.makeEmptyResponse(HttpStatus.ok),
      );
      // Act
      await sut.request(url: url, method: method, body: body);
      // Assert
      verify(() => client.post(
            Uri.parse(url),
            headers: HttpAdapter.headers,
            body: jsonEncode(body),
          ));
    });

    test('Should call post() without body', () async {
      // Arrange
      client = ClientSpy();
      sut = HttpAdapter(client);
      //client.mockPost(url);
      when(() => client.post(
            Uri.parse(url),
            headers: HttpAdapter.headers,
          )).thenAnswer(
        (_) async => HttpFactory.makeEmptyResponse(HttpStatus.ok),
      );
      // Act
      await sut.request(url: url, method: method);
      // Assert
      verify(() => client.post(
            Uri.parse(url),
            headers: any(named: 'headers'),
          ));
    });
  });
}
