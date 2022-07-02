import 'package:fordev_tdd/domain/entities/account_entity.dart';
import 'package:fordev_tdd/domain/usecases/load_current_account.dart';
import 'package:mocktail/mocktail.dart';

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {
  void mockLoad({required AccountEntity? account}) {
    when(() => load())
        .thenAnswer((_) async => (account != null) ? account : null);
  }

  void mockLoadError() {
    when(() => load()).thenThrow(Exception());
  }
}
