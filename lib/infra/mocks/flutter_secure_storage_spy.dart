// ignore: depend_on_referenced_packages
import 'package:mocktail/mocktail.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageSpy extends Mock implements FlutterSecureStorage {
  void mockWrite(String key, String value) {
    when(() => write(key: key, value: value))
        .thenAnswer((_) => Future<void>(() {}));
  }

  void mockWriteError(String key, String value) {
    when(() => write(key: any(named: 'key'), value: any(named: 'value')))
        .thenThrow(Exception());
  }
}
