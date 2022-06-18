import 'package:faker/faker.dart';
import 'package:fordev_tdd/data/usecases/usecases.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/data/http/http.dart';
import 'package:fordev_tdd/domain/usecases/usecases.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  const String method = 'post';
  late String url;
  late HttpClientSpy client;
  late RemoteAuthentication sut;
  late AuthenticationParams params;
  late Map<String, dynamic> body;

  setUp(() {
    url = faker.internet.httpUrl();
    client = HttpClientSpy();
    sut = RemoteAuthentication(httpClient: client, url: url);
    params = AuthenticationParams(
      email: faker.internet.email(),
      password: faker.internet.password(),
    );
    body = {
      'email': params.email,
      'password': params.password,
    };
  });

  test('Should call HttpClient with correct URL', () {
    // Arrange
    when(() => client.request(
          url: url,
          method: method,
          body: body,
        )).thenAnswer((_) async {});

    // Act
    sut.auth(params);

    // Assert
    verify(() => client.request(
          url: url,
          method: 'post',
          body: body,
        ));
  });
}
