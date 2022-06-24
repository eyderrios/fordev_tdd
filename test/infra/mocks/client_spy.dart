import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:fordev_tdd/infra/mocks/mocks.dart';

class ClientSpy extends Mock implements http.Client {
  ClientSpy() {
    registerFallbackValue(Uri());
  }

  When _mockPostCall() => when(() => post(
        any(),
        body: any(named: 'body'),
        headers: any(named: 'headers'),
      ));

  void mockResponse(int statusCode, String body) => _mockPostCall()
      .thenAnswer((_) async => HttpFactory.makeResponse(statusCode, body));
}
