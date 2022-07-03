import 'dart:async';

import 'package:fordev_tdd/ui/helpers/errors/errors.dart';
import 'package:fordev_tdd/ui/pages/signup/sigup_presenter.dart';
import 'package:mocktail/mocktail.dart';

class SignUpPresenterSpy extends Mock implements SignUpPresenter {
  final nameErrorController = StreamController<UIError?>();
  final emailErrorController = StreamController<UIError?>();
  final passwordErrorController = StreamController<UIError?>();
  final passwordConfirmationErrorController = StreamController<UIError?>();
  final isFormValidController = StreamController<bool>();

  SignUpPresenterSpy() {
    _mockMethods();
  }

  void _mockMethods() {
    when(() => nameErrorStream).thenAnswer((_) => nameErrorController.stream);
    when(() => emailErrorStream).thenAnswer((_) => emailErrorController.stream);
    when(() => passwordErrorStream)
        .thenAnswer((_) => passwordErrorController.stream);
    when(() => passwordConfirmationErrorStream)
        .thenAnswer((_) => passwordConfirmationErrorController.stream);

    when(() => isFormValidStream)
        .thenAnswer((_) => isFormValidController.stream);
  }

  void emitNameError(UIError? error) => nameErrorController.add(error);
  void emitEmailError(UIError? error) => emailErrorController.add(error);
  void emitPasswordError(UIError? error) => passwordErrorController.add(error);
  void emitPasswordConfirmationError(UIError? error) =>
      passwordConfirmationErrorController.add(error);

  void emitFormValid() => isFormValidController.add(true);
  void emitFormError() => isFormValidController.add(false);

  @override
  Future<void> signUp() {
    return Future(() {});
  }

  @override
  void dispose() {
    nameErrorController.close();
    emailErrorController.close();
    passwordErrorController.close();
    passwordConfirmationErrorController.close();
    isFormValidController.close();
  }
}
