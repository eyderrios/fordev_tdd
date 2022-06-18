import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

abstract class HttpClient {
  Future<void> request({
    required String url,
    required String method,
  });
}

class HttpClientSpy extends Mock implements HttpClient {}

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({
    required this.httpClient,
    required this.url,
  });

  Future<void> auth() async {
    await httpClient.request(url: url, method: 'post');
  }
}

void main() {
  test('Should call HttpClient with correct URL', () {
    // Arrange
    const method = 'post';
    final url = faker.internet.httpUrl();
    final client = HttpClientSpy();
    final sut = RemoteAuthentication(httpClient: client, url: url);

    when(() => client.request(
          url: url,
          method: method,
        )).thenAnswer((_) async {});

    // Act
    sut.auth();

    // Assert
    verify(() => client.request(
          url: url,
          method: 'post',
        )).called(1);
  });
}
