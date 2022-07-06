typedef HttpClientBody = Map<String, dynamic>;

abstract class HttpClient<ResponseType> {
  Future<ResponseType?> request({
    required String url,
    required String method,
    HttpClientBody? body,
  });
}
