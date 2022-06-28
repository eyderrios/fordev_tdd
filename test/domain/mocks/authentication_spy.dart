import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/domain/helpers/domain_error.dart';
import 'package:fordev_tdd/domain/usecases/usecases.dart';

import 'entity_factory.dart';
import 'params_factory.dart';

class AuthenticationSpy extends Mock implements Authentication {
  AuthenticationSpy() {
    registerFallbackValue(ParamsFactory.makeAuthenticationParams());
  }

  When _mockAuth(AuthenticationParams? params) {
    params ??= any();
    return when(() => auth(params!));
  }

  void mockAuth(AuthenticationParams? params, {String? token}) {
    _mockAuth(params).thenAnswer(
      (_) async => EntityFactory.makeAccountEntity(token: token),
    );
  }

  void mockAuthError(AuthenticationParams? params, DomainError error) {
    _mockAuth(params).thenThrow(error);
  }
}
