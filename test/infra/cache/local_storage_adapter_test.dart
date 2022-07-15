import 'package:faker/faker.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class LocalStorageAdapter {
  LocalStorage localStorage;

  LocalStorageAdapter({
    required this.localStorage,
  });

  Future<void> save({required String key, required dynamic value}) async {
    await localStorage.setItem(key, value);
    return Future<void>(() {});
  }
}

class LocalStorageSpy extends Mock implements LocalStorage {
  void mockSetItem() {
    when(() => setItem(any(), any())).thenAnswer((_) async => _);
  }
}

void main() {
  late String key = faker.randomGenerator.string(8);
  late String value = faker.randomGenerator.string(50);
  late LocalStorageAdapter sut;
  late LocalStorageSpy storage;

  setUp(() {
    storage = LocalStorageSpy();
    sut = LocalStorageAdapter(localStorage: storage);
  });

  test('Should call LocalStorage with correct params', () async {
    // Arrange
    storage.mockSetItem();
    // Act
    await sut.save(key: key, value: value);
    // Assert
    verify(() => storage.setItem(key, value)).called(1);
  });
}
