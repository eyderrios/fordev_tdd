import 'package:http/http.dart';

class HttpFactory {
  static String makeBody() => '{"some_key":"some_data"}';

  static String makeEmptyBody() => '';

  static Response makeResponse(int statusCode, String body) =>
      Response(body, statusCode);

  static Response makeEmptyResponse(int statusCode) =>
      makeResponse(statusCode, '');
}
