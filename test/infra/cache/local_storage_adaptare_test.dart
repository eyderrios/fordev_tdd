// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:faker/faker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/data/cache/cache.dart';

class LocalStorageAdapter implements SaveSecureCacheStorage {
  FlutterSecureStorage secureStorage;

  LocalStorageAdapter({required this.secureStorage});

  @override
  Future<void> saveSecure({required String key, required String value}) async {
    await secureStorage.write(key: key, value: value);
  }
}

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

void main() {
  late String key;
  late String value;
  late FlutterSecureStorageSpy storage;
  late LocalStorageAdapter sut;

  setUp(() {
    key = faker.lorem.word();
    value = faker.guid.guid();
    storage = FlutterSecureStorageSpy();
    sut = LocalStorageAdapter(secureStorage: storage);
  });

  test('Should call SaveSecure with correct params', () async {
    storage.mockWrite(key, value);

    await sut.saveSecure(key: key, value: value);

    verify(() => storage.write(key: key, value: value)).called(1);
  });

  test('Should throw if SaveSecure throws', () async {
    storage.mockWriteError(key, value);

    final future = sut.saveSecure(key: key, value: value);

    expect(future, throwsA(const TypeMatcher<Exception>()));
  });
}
