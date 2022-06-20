import 'dart:io';

import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class ClientSpy extends Mock implements Client {
  void mockPost(String url) {
    when(() => post(
          Uri.parse(url),
          headers: any(named: 'headers'),
        )).thenAnswer(
      (_) async => Response('{}', HttpStatus.ok),
    );
  }
}
