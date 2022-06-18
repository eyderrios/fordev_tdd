import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/data/http/http.dart';

class HttpAdapter {
  final Client client;

  HttpAdapter(this.client);

  Future<void> request({
    required String url,
    required String method,
    HttpClientBody? body,
  }) async {
    await client.post(Uri.parse(url));
  }
}

class ClientSpy extends Mock implements Client {
  Response mockValidResponse() => Response('{}', 200);
}

void main() {
  group('POST', () {
    test('Should call post() with correct values', () async {
      // Arrange
      const method = 'post';
      final client = ClientSpy();
      final sut = HttpAdapter(client);
      final url = faker.internet.httpUrl();

      when(() => client.post(Uri.parse(url))).thenAnswer(
        (_) async => client.mockValidResponse(),
      );
      // Act
      await sut.request(url: url, method: method);
      // Assert
      verify(() => client.post(Uri.parse(url)));
    });
  });
}
