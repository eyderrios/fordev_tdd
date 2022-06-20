import 'package:http/http.dart';

class HttpFactory {
  static Map<String, dynamic> makeBody() => {
        'some_key': 'some_data',
      };
  static Response makeResponse(int statusCode) =>
      Response('{"some_key":"some_data"}', statusCode);
}
