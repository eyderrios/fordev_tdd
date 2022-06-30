import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/infra/mocks/flutter_secure_storage_spy.dart';
import 'package:fordev_tdd/infra/cache/cache.dart';

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

  group('saveSecure', () {
    test('Should call saveSecure with correct params', () async {
      storage.mockWrite(key, value);

      await sut.saveSecure(key: key, value: value);

      verify(() => storage.write(key: key, value: value)).called(1);
    });

    test('Should throw if saveSecure throws', () async {
      storage.mockWriteError(key, value);

      final future = sut.saveSecure(key: key, value: value);

      expect(future, throwsA(const TypeMatcher<Exception>()));
    });
  });

  group('fetchSecure', () {
    test('Should call fetchSecure with correct param', () async {
      storage.mockRead(key);

      await sut.fetchSecure(key);

      verify(() => storage.read(key: key)).called(1);
    });
  });
}
