import 'dart:async';

import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/ui/pages/login/login_presenter.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {
  final emailErrorController = StreamController<String>();

  LoginPresenterSpy() {
    when(() => emailErrorStream).thenAnswer((_) => emailErrorController.stream);
  }

  void emitEmailError(String error) => emailErrorController.add(error);

  void dispose() {
    emailErrorController.close();
  }
}
