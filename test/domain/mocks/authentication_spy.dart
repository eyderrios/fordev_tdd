import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/domain/entities/entities.dart';
import 'package:fordev_tdd/domain/usecases/usecases.dart';

class AuthenticationSpy extends Mock implements Authentication {
  static const token = 'some_auth_token';

  void mockAuth(AuthenticationParams params) {
    when(() => auth(any())).thenAnswer(
      (_) async => AccountEntity(
        token: AuthenticationSpy.token,
      ),
    );
  }
}
