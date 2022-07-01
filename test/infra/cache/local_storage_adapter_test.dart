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
      // Arrange
      storage.mockWrite(key, value);
      // Act
      await sut.saveSecure(key: key, value: value);
      // Assert
      verify(() => storage.write(key: key, value: value)).called(1);
    });

    test('Should throw if saveSecure throws', () async {
      // Arrange
      storage.mockWriteError(key, value);
      // Act
      final future = sut.saveSecure(key: key, value: value);
      // Assert
      expect(future, throwsA(const TypeMatcher<Exception>()));
    });
  });

  group('fetchSecure', () {
    test('Should call fetchSecure with correct param', () async {
      // Arrange
      storage.mockRead(value);
      // Act
      await sut.fetchSecure(key);
      // Assert
      verify(() => storage.read(key: key)).called(1);
    });

    test('Should return correct value on success', () async {
      // Arrange
      storage.mockRead(value);
      // Act
      final fetchedValue = await sut.fetchSecure(key);
      // Assert
      expect(fetchedValue, value);
    });

    test('Should throw if fetchSecure throws', () async {
      // Arrange
      storage.mockReadError();
      // Act
      final future = sut.fetchSecure(key);
      // Assert
      expect(future, throwsA(const TypeMatcher<Exception>()));
    });
  });
}
