import 'dart:async';

import 'package:fordev_tdd/ui/helpers/errors/errors.dart';
import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/ui/pages/login/login_presenter.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {
  final emailErrorController = StreamController<UIError?>();
  final passwordErrorController = StreamController<UIError?>();
  final mainErrorController = StreamController<UIError?>();
  final navigateToController = StreamController<String?>();
  final isFormValidController = StreamController<bool>();
  final isLoadingController = StreamController<bool>();

  LoginPresenterSpy() {
    _mockMethods();
  }

  void _mockMethods() {
    when(() => goToSignUp()).thenReturn(null);

    when(() => auth()).thenAnswer((_) async => _);

    when(() => emailErrorStream).thenAnswer((_) => emailErrorController.stream);
    when(() => passwordErrorStream)
        .thenAnswer((_) => passwordErrorController.stream);
    when(() => mainErrorStream).thenAnswer((_) => mainErrorController.stream);
    when(() => navigateToStream).thenAnswer((_) => navigateToController.stream);
    when(() => isFormValidStream)
        .thenAnswer((_) => isFormValidController.stream);
    when(() => isLoadingStream).thenAnswer((_) => isLoadingController.stream);
  }

  void emitEmailError(UIError? error) => emailErrorController.add(error);
  void emitPasswordError(UIError? error) => passwordErrorController.add(error);
  void emitMainError(UIError? error) => mainErrorController.add(error);

  void emitFormValid() => isFormValidController.add(true);
  void emitFormError() => isFormValidController.add(false);

  void emitLoadind(bool show) => isLoadingController.add(show);
  void emitNavigateTo(String route) => navigateToController.add(route);

  @override
  void dispose() {
    emailErrorController.close();
    passwordErrorController.close();
    mainErrorController.close();
    navigateToController.close();
    isFormValidController.close();
    isLoadingController.close();
  }
}
