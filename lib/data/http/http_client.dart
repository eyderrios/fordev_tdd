import 'dart:ffi';

abstract class HttpClient {
  Future<Map<String, dynamic>> request({
    required String url,
    required String method,
    Map<String, dynamic>? body,
  });
}
