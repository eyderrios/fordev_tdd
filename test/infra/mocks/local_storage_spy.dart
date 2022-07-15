import 'package:localstorage/localstorage.dart';
import 'package:mocktail/mocktail.dart';

class LocalStorageSpy extends Mock implements LocalStorage {
  When _deleteItemCall() => when(() => deleteItem(any()));
  When _getItemCall() => when(() => getItem(any()));
  When _setItemCall() => when(() => setItem(any(), any()));

  void mockDeleteItem() {
    _deleteItemCall().thenAnswer((_) async => _);
  }

  void mockSetItem() {
    _setItemCall().thenAnswer((_) async => _);
  }

  void mockGetItem(dynamic value) {
    _getItemCall().thenAnswer((_) async => value);
  }

  void mockDeleteItemError() {
    _deleteItemCall().thenThrow(Exception());
  }

  void mockSetItemError() {
    _setItemCall().thenThrow(Exception());
  }

  void mockGetItemError() {
    _getItemCall().thenThrow(Exception());
  }
}
