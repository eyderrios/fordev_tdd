import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/domain/helpers/domain_error.dart';
import 'package:fordev_tdd/main/factories/factories.dart';
import 'package:fordev_tdd/domain/usecases/add_account.dart';

import '../../domain/mocks/entity_factory.dart';

class AddAccountSpy extends Mock implements AddAccount {
  AddAccountSpy() {
    registerFallbackValue(AddAccountFactory.makeAddAccountParams());
  }

  void mockAdd(String? token) {
    when(() => add(any()))
        .thenAnswer((_) async => EntityFactory.makeAccountEntity(token: token));
  }

  void mockAddError(DomainError error) {
    when(() => add(any())).thenThrow(error);
  }
}
