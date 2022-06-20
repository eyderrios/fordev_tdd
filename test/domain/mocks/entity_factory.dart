import 'package:faker/faker.dart';

import 'package:fordev_tdd/domain/entities/account_entity.dart';

class EntityFactory {
  static AccountEntity makeAccount() => AccountEntity(
        token: faker.guid.guid(),
      );
}
