import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/data/http/http.dart';

class HttpClientSpy extends Mock implements HttpClient {
  When _mockRequestCall() => when(() => request(
        url: any(named: 'url'),
        method: any(named: 'method'),
        body: any(named: 'body'),
      ));

  void mockRequest(Map<String, dynamic> data) =>
      _mockRequestCall().thenAnswer((_) async => data);

  void mockRequestError(HttpError error) => _mockRequestCall().thenThrow(error);
}
