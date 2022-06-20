import 'dart:io';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/infra/http/http_adapter.dart';
import 'package:fordev_tdd/infra/mocks/http_factory.dart';
import '../mocks/mocks.dart';

void main() {
  const method = 'post';
  final url = faker.internet.httpUrl();

  late HttpAdapter sut;
  late ClientSpy client;

  group('POST', () {
    test('Should call post() with correct parameters (url, headers, body)',
        () async {
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
            headers: HttpAdapter.headers,
          ));
    });

    test('Should call post() with correct parameters', () async {
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
            headers: HttpAdapter.headers,
          ));
    });
  });
}
