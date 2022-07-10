import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../data/http/http.dart';

class HttpAdapter implements HttpClient {
  static const getMethod = 'get';
  static const postMethod = 'post';

  static const Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  final Client client;

  HttpAdapter(this.client);

  dynamic _handleResponse(Response response) {
    dynamic body;

    switch (response.statusCode) {
      case HttpStatus.ok:
        try {
          // _TypeError (type 'List<dynamic>'
          //  is not a subtype of type 'List<Map<String, dynamic>>?')
          body = (response.body.isNotEmpty)
              ? body = jsonDecode(response.body)
              : null;
        } catch (error) {
          rethrow;
        }
        break;
      case HttpStatus.noContent:
        body = null;
        break;
      case HttpStatus.badRequest:
        throw HttpError.badRequest;
      case HttpStatus.unauthorized:
        throw HttpError.unauthorized;
      case HttpStatus.forbidden:
        throw HttpError.forbidden;
      case HttpStatus.notFound:
        throw HttpError.notFound;
      default:
        throw HttpError.serverError;
    }
    return body;
  }

  @override
  Future<dynamic> request({
    required String url,
    required String method,
    HttpClientBody? body,
    HttpClientHeaders? headers,
  }) async {
    final HttpClientHeaders allHeaders = {};
    final String? jsonBody = (body != null) ? jsonEncode(body) : null;
    Response response;

    allHeaders.addAll(HttpAdapter.headers);
    if (headers != null) {
      allHeaders.addAll(headers);
    }

    try {
      if (method == HttpAdapter.postMethod) {
        response = await client.post(
          Uri.parse(url),
          body: jsonBody,
          headers: allHeaders,
        );
      } else if (method == HttpAdapter.getMethod) {
        response = await client.get(
          Uri.parse(url),
          headers: allHeaders,
        );
      } else {
        response = Response('', HttpStatus.internalServerError);
      }
    } catch (error) {
      throw HttpError.serverError;
    }
    return _handleResponse(response);
  }
}
