import 'package:faker/faker.dart';

import 'package:fordev_tdd/domain/entities/account_entity.dart';

class EntityFactory {
  static AccountEntity makeAccountEntity({String? token}) => AccountEntity(
        token: token ?? faker.guid.guid(),
      );
}
