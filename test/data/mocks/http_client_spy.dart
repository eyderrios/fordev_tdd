import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/data/http/http.dart';

class HttpClientSpy<ResponseType> extends Mock
    implements HttpClient<ResponseType> {
  HttpClientSpy() {
    registerFallbackValue(Uri());
  }

  When _mockRequestCall() => when(() => request(
        url: any(named: 'url'),
        method: any(named: 'method'),
        body: any(named: 'body'),
        headers: any(named: 'headers'),
      ));

  void mockRequest(ResponseType response) {
    _mockRequestCall().thenAnswer((_) async => response);
  }

  void mockRequestError(HttpError error) {
    _mockRequestCall().thenThrow(error);
  }
}
