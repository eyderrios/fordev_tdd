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

  HttpClientBody? _handleResponse(Response response) {
    HttpClientBody? body;

    switch (response.statusCode) {
      case HttpStatus.ok:
        body = response.body.isNotEmpty ? jsonDecode(response.body) : null;
        break;
      case HttpStatus.noContent:
        body = null;
        break;
      case HttpStatus.badRequest:
        throw HttpError.badRequest;
      default:
        throw HttpError.serverError;
    }
    return body;
  }

  @override
  Future<HttpClientBody?> request({
    required String url,
    required String method,
    HttpClientBody? body,
  }) async {
    final jsonBody = (body != null) ? jsonEncode(body) : null;
    final response = await client.post(
      Uri.parse(url),
      headers: HttpAdapter.headers,
      body: jsonBody,
    );
    return _handleResponse(response);
  }
}
