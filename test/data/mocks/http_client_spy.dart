import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/data/http/http.dart';

class HttpClientSpy extends Mock implements HttpClient {
  HttpClientSpy() {
    registerFallbackValue(Uri.parse('http://www.example.com'));
  }

  When _mockRequestCall() => when(() => request(
        url: any(named: 'url'),
        method: any(named: 'method'),
        body: any(named: 'body'),
      ));

  void mockRequest(HttpClientBody data) =>
      _mockRequestCall().thenAnswer((_) async => data);

  void mockRequestError(HttpError error) => _mockRequestCall().thenThrow(error);
}
