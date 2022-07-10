typedef HttpClientBody = Map<String, dynamic>;
typedef HttpClientHeaders = Map<String, String>;

abstract class HttpClient {
  Future<dynamic> request({
    required String url,
    required String method,
    HttpClientBody? body,
    HttpClientHeaders? headers,
  });
}
