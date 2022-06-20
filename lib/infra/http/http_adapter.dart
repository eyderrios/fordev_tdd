import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../data/http/http.dart';

class HttpAdapter {
  static const headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  final Client client;

  HttpAdapter(this.client);

  Future<void> request({
    required String url,
    required String method,
    HttpClientBody? body,
  }) async {
    await client.post(
      Uri.parse(url),
      headers: HttpAdapter.headers,
      body: (body != null) ? jsonEncode(body) : null,
    );
  }
}
