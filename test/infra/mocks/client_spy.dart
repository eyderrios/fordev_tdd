import 'package:fordev_tdd/main/factories/factories.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class ClientSpy extends Mock implements http.Client {
  ClientSpy() {
    registerFallbackValue(Uri());
  }

  When _mockPostCall() => when(() => post(
        any(),
        body: any(named: 'body'),
        headers: any(named: 'headers'),
      ));

  When _mockGetCall() => when(() => get(
        any(),
        headers: any(named: 'headers'),
      ));

  void mockPost(int statusCode, String body) => _mockPostCall()
      .thenAnswer((_) async => HttpFactory.makeResponse(statusCode, body));

  void mockPostError() => _mockPostCall().thenThrow(Exception());

  void mockGet(int statusCode, String body) => _mockGetCall()
      .thenAnswer((_) async => HttpFactory.makeResponse(statusCode, body));

  void mockGetError() => _mockGetCall().thenThrow(Exception());
}
