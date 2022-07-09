typedef HttpClientBody = Map<String, dynamic>;
typedef HttpClientHeaders = Map<String, String>;

abstract class HttpClient<ResponseType> {
  Future<ResponseType?> request({
    required String url,
    required String method,
    HttpClientBody? body,
    HttpClientHeaders? headers,
  });
}
