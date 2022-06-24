import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../data/http/http.dart';

class HttpAdapter implements HttpClient {
  static const Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  final Client client;

  HttpAdapter(this.client);

  @override
  Future<HttpClientBody?> request({
    required String url,
    required String method,
    HttpClientBody? body,
  }) async {
    final response = await client.post(
      Uri.parse(url),
      headers: HttpAdapter.headers,
      body: (body != null) ? jsonEncode(body) : null,
    );
    return response.body.isNotEmpty ? jsonDecode(response.body) : null;
  }
}
