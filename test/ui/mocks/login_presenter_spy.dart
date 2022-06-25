import 'dart:async';

import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/ui/pages/login/login_presenter.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {
  final emailErrorController = StreamController<String>();
  final passwordErrorController = StreamController<String>();
  final mainErrorController = StreamController<String>();
  final isFormValidController = StreamController<bool>();
  final isLoadingController = StreamController<bool>();

  LoginPresenterSpy() {
    when(() => emailErrorStream).thenAnswer((_) => emailErrorController.stream);
    when(() => passwordErrorStream)
        .thenAnswer((_) => passwordErrorController.stream);
    when(() => mainErrorStream).thenAnswer((_) => mainErrorController.stream);
    when(() => isFormValidStream)
        .thenAnswer((_) => isFormValidController.stream);
    when(() => isLoadingStream).thenAnswer((_) => isLoadingController.stream);
  }

  void emitEmailError(String error) => emailErrorController.add(error);
  void emitPasswordError(String error) => passwordErrorController.add(error);
  void emitFormValid() => isFormValidController.add(true);
  void emitFormError() => isFormValidController.add(false);
  void emitLoadind(bool show) => isLoadingController.add(show);
  void emitMainError(String error) => mainErrorController.add(error);

  @override
  void dispose() {
    emailErrorController.close();
    passwordErrorController.close();
    mainErrorController.close();
    isFormValidController.close();
    isLoadingController.close();
  }
}
