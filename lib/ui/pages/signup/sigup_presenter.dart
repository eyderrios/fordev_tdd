import '../../helpers/errors/errors.dart';

abstract class SignUpPresenter {
  Stream<UIError?> get mainErrorStream;
  Stream<UIError?> get nameErrorStream;
  Stream<UIError?> get emailErrorStream;
  Stream<UIError?> get passwordErrorStream;
  Stream<UIError?> get passwordConfirmationErrorStream;
  Stream<bool> get isFormValidStream;
  Stream<bool> get isLoadingStream;
  Stream<String?> get navigateToStream;

  void validateName(String email);
  void validateEmail(String email);
  void validatePassword(String password);
  void validatePasswordConfirmation(String password);

  void goToLogin();

  Future<void> signUp();

  void dispose();
}
