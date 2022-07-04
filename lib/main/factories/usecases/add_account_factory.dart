// ignore: depend_on_referenced_packages
import 'package:faker/faker.dart';

import '../../../domain/usecases/usecases.dart';

class AddAccountFactory {
  static AddAccountParams makeAddAccountParams() {
    final password = faker.internet.password();

    return AddAccountParams(
      name: faker.person.name(),
      email: faker.internet.email(),
      password: password,
      passwordConfirmation: password,
    );
  }
}
