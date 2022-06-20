import 'package:faker/faker.dart';

import 'package:fordev_tdd/domain/usecases/usecases.dart';

class ParamsFactory {
  static AuthenticationParams makeAuthenticationParams() =>
      AuthenticationParams(
        email: faker.internet.email(),
        password: faker.internet.password(),
      );
}
