import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/data/http/http.dart';

class HttpClientSpy extends Mock implements HttpClient {
  HttpClientSpy() {
    registerFallbackValue(Uri());
  }

  When _mockRequestCall() => when(() => request(
        url: any(named: 'url'),
        method: any(named: 'method'),
        body: any(named: 'body'),
        headers: any(named: 'headers'),
      ));

  void mockRequest(dynamic response) {
    _mockRequestCall().thenAnswer((_) async => response);
  }

  void mockRequestError(HttpError error) {
    _mockRequestCall().thenThrow(error);
  }
}
