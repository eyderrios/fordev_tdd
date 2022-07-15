import 'package:http/http.dart' as http;

import '../../../data/http/http.dart';
import '../../../infra/http/http.dart';
import '../../decorators/decorators.dart';
import '../cache/cache.dart';

class HttpClientFactory {
  static HttpClient makeHttpAdapter() => HttpAdapter(http.Client());

  static HttpClient makeAuthorizeHttpClientDecorator() =>
      AuthorizeHttpClientDecorator(
        fetchSecureCacheStorage:
            SecureStorageAdapterFactory.makeSecureStorageAdapter(),
        decoratee: HttpClientFactory.makeHttpAdapter(),
      );
}
