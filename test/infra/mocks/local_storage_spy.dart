import 'package:localstorage/localstorage.dart';
import 'package:mocktail/mocktail.dart';

class LocalStorageSpy extends Mock implements LocalStorage {
  void mockDeleteItem() {
    when(() => deleteItem(any())).thenAnswer((_) async => _);
  }

  void mockSetItem() {
    when(() => setItem(any(), any())).thenAnswer((_) async => _);
  }

  void mockDeleteItemError() {
    when(() => deleteItem(any())).thenThrow(Exception());
  }

  void mockSetItemError() {
    when(() => setItem(any(), any())).thenThrow(Exception());
  }
}
