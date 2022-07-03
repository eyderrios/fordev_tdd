import 'dart:async';

import 'package:fordev_tdd/ui/helpers/errors/errors.dart';
import 'package:fordev_tdd/ui/pages/signup/sigup_presenter.dart';
import 'package:mocktail/mocktail.dart';

class SignUpPresenterSpy extends Mock implements SignUpPresenter {
  final mainErrorController = StreamController<UIError?>();
  final nameErrorController = StreamController<UIError?>();
  final emailErrorController = StreamController<UIError?>();
  final passwordErrorController = StreamController<UIError?>();
  final passwordConfirmationErrorController = StreamController<UIError?>();
  final isFormValidController = StreamController<bool>();
  final isLoadingController = StreamController<bool>();

  SignUpPresenterSpy() {
    _mockMethods();
  }

  void _mockMethods() {
    when(() => mainErrorStream).thenAnswer((_) => mainErrorController.stream);
    when(() => nameErrorStream).thenAnswer((_) => nameErrorController.stream);
    when(() => emailErrorStream).thenAnswer((_) => emailErrorController.stream);
    when(() => passwordErrorStream)
        .thenAnswer((_) => passwordErrorController.stream);
    when(() => passwordConfirmationErrorStream)
        .thenAnswer((_) => passwordConfirmationErrorController.stream);

    when(() => isFormValidStream)
        .thenAnswer((_) => isFormValidController.stream);
    when(() => isLoadingStream).thenAnswer((_) => isLoadingController.stream);

    when(() => signUp()).thenAnswer((_) async => _);
  }

  void emitMainError(UIError? error) => mainErrorController.add(error);
  void emitNameError(UIError? error) => nameErrorController.add(error);
  void emitEmailError(UIError? error) => emailErrorController.add(error);
  void emitPasswordError(UIError? error) => passwordErrorController.add(error);
  void emitPasswordConfirmationError(UIError? error) =>
      passwordConfirmationErrorController.add(error);

  void emitFormValid() => isFormValidController.add(true);
  void emitFormError() => isFormValidController.add(false);

  void emitLoadind(bool show) => isLoadingController.add(show);

  @override
  void dispose() {
    mainErrorController.close();
    nameErrorController.close();
    emailErrorController.close();
    passwordErrorController.close();
    passwordConfirmationErrorController.close();
    isFormValidController.close();
    isLoadingController.close();
  }
}
