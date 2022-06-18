typedef HttpClientBody = Map<String, dynamic>;

abstract class HttpClient {
  Future<HttpClientBody> request({
    required String url,
    required String method,
    HttpClientBody? body,
  });
}
