import 'package:faker/faker.dart';
import 'package:fordev_tdd/infra/cache/local_storage_adapter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../mocks/local_storage_spy.dart';

void main() {
  late LocalStorageAdapter sut;
  late LocalStorageSpy storage;
  late String key;
  late dynamic value;

  setUp(() {
    storage = LocalStorageSpy();
    sut = LocalStorageAdapter(localStorage: storage);
    key = faker.randomGenerator.string(8);
    value = faker.randomGenerator.string(50);
  });

  test('Should call LocalStorage with correct params', () async {
    // Arrange
    storage.mockDeleteItem();
    storage.mockSetItem();
    // Act
    await sut.save(key: key, value: value);
    // Assert
    verify(() => storage.deleteItem(key)).called(1);
    verify(() => storage.setItem(key, value)).called(1);
  });

  test('Should throws if deleteItem throws', () {
    // Arrange
    storage.mockDeleteItemError();
    // Act
    final future = sut.save(key: key, value: value);
    // Assert
    expect(future, throwsA(const TypeMatcher<Exception>()));
  });

  test('Should throws if setItem throws', () {
    // Arrange
    storage.mockDeleteItem();
    storage.mockSetItemError();
    // Act
    final future = sut.save(key: key, value: value);
    // Assert
    expect(future, throwsA(const TypeMatcher<Exception>()));
  });
}
