import '../../data/cache/cache.dart';
import '../../data/http/http.dart';

class AuthorizeHttpClientDecorator implements HttpClient {
  final FetchSecureCacheStorage fetchSecureCacheStorage;
  final HttpClient decoratee;

  AuthorizeHttpClientDecorator({
    required this.fetchSecureCacheStorage,
    required this.decoratee,
  });

  @override
  Future<dynamic> request({
    required String url,
    required String method,
    HttpClientBody? body,
    HttpClientHeaders? headers,
  }) async {
    try {
      final token = await fetchSecureCacheStorage.fetchSecure('token');
      HttpClientHeaders authHeaders = {};
      if (token != null) {
        authHeaders.addAll({'x-access-token': token});
      }
      if (headers != null) {
        authHeaders.addAll(headers);
      }
      return await decoratee.request(
        url: url,
        method: method,
        body: body,
        headers: authHeaders.isNotEmpty ? authHeaders : null,
      );
    } on HttpError {
      rethrow;
    } catch (error) {
      throw HttpError.forbidden;
    }
  }
}
