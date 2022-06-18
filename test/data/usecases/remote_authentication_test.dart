import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/domain/usecases/usecases.dart';

abstract class HttpClient {
  Future<void> request({
    required String url,
    required String method,
    Map? body,
  });
}

class HttpClientSpy extends Mock implements HttpClient {}

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;
  Map? body;

  RemoteAuthentication({
    required this.httpClient,
    required this.url,
    this.body,
  });

  Future<void> auth(AuthenticationParams params) async {
    final body = {
      'email': params.email,
      'password': params.password,
    };
    await httpClient.request(
      url: url,
      method: 'post',
      body: body,
    );
  }
}

void main() {
  const String method = 'post';
  late String url;
  late HttpClientSpy client;
  late RemoteAuthentication sut;
  late AuthenticationParams params;

  setUp(() {
    url = faker.internet.httpUrl();
    client = HttpClientSpy();
    sut = RemoteAuthentication(httpClient: client, url: url);
    params = AuthenticationParams(
      email: faker.internet.email(),
      password: faker.internet.password(),
    );
  });

  test('Should call HttpClient with correct URL', () {
    // Arrange
    when(() => client.request(
          url: url,
          method: method,
        )).thenAnswer((_) async {});

    // Act
    sut.auth(params);

    // Assert
    verify(() => client.request(
          url: url,
          method: 'post',
          body: {
            'email': params.email,
            'password': params.password,
          },
        ));
  });
}
