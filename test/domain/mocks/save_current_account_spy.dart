import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/domain/entities/entities.dart';
import 'package:fordev_tdd/domain/usecases/usecases.dart';

class SaveCurrentAccountSpy extends Mock implements SaveCurrentAccount {
  SaveCurrentAccountSpy() {
    registerFallbackValue(AccountEntity(token: faker.guid.guid()));
  }

  void mockSave() {
    when(() => save(any())).thenAnswer((_) => Future(() {}));
  }
}
