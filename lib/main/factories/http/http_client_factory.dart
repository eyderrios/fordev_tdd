import 'package:http/http.dart' as http;

import '../../../data/http/http.dart';
import '../../../infra/http/http.dart';

class HttpClientFactory {
  static HttpClient makeHttpAdapter() {
    final client = http.Client();
    return HttpAdapter(client);
  }
}
