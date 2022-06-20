import 'dart:convert';

import 'package:http/http.dart';

class HttpFactory {
  static Map<String, dynamic> makeBody() => {
        'some_key': 'some_data',
      };

  static Map<String, dynamic> makeEmptyBody() => {};

  static Response makeResponse(int statusCode) =>
      Response(jsonEncode(makeBody()), statusCode);

  static Response makeEmptyResponse(int statusCode) => Response('', statusCode);
}
