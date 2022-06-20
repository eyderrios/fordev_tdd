import 'package:http/http.dart';

class HttpFactory {
  static Response makeEmptyResponse(int statusCode) =>
      Response('{}', statusCode);
}
