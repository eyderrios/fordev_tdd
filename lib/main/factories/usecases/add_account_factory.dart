// ignore: depend_on_referenced_packages
import 'package:faker/faker.dart';

import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

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

  static AddAccount makeRemoteAddAccount() => RemoteAddAccount(
        httpClient: HttpClientFactory.makeHttpAdapter(),
        url: ApiUrlFactory.makeApiUrl('signup'),
      );
}
