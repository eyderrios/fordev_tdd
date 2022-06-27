import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/domain/usecases/usecases.dart';

import 'entity_factory.dart';
import 'params_factory.dart';

class AuthenticationSpy extends Mock implements Authentication {
  AuthenticationSpy() {
    registerFallbackValue(ParamsFactory.makeAuthenticationParams());
  }

  void mockAuth(AuthenticationParams? params) {
    params ??= any();
    when(() => auth(params!)).thenAnswer(
      (_) async => EntityFactory.makeAccountEntity(),
    );
  }
}
