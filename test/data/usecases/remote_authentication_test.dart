import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

abstract class HttpClient {
  Future<void> request({required String url});
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
    await httpClient.request(url: url);
  }
}

void main() {
  test('Should call HttpClient with correct URL', () {
    // Arrange
    final url = faker.internet.httpUrl();
    final httpClient = HttpClientSpy();
    final sut = RemoteAuthentication(httpClient: httpClient, url: url);

    when(() => httpClient.request(url: url)).thenAnswer((_) async {});
    // Act
    sut.auth();
    // Assert
    verify(() => httpClient.request(url: url)).called(1);
  });
}
