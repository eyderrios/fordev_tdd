import 'package:get/get.dart';

import '../../ui/helpers/errors/errors.dart';
import '../protocols/validator.dart';

class GetxSignUpPresenter extends GetxController {
  static const nameFieldName = 'name';
  static const emailFieldName = 'email';
  static const passwordFieldName = 'password';
  static const passwordConfirmationFieldName = 'passwordConfirmation';

  final Validator validator;

  final _nameError = Rx<UIError?>(null);
  final _emailError = Rx<UIError?>(null);
  final _passwordError = Rx<UIError?>(null);
  final _passwordConfirmationError = Rx<UIError?>(null);
  final _isFormValid = RxBool(false);

  GetxSignUpPresenter({
    required this.validator,
  });

  Stream<UIError?> get nameErrorStream => _nameError.stream;
  Stream<UIError?> get emailErrorStream => _emailError.stream;
  Stream<UIError?> get passwordErrorStream => _passwordError.stream;
  Stream<UIError?> get passwordConfirmationErrorStream =>
      _passwordConfirmationError.stream;

  Stream<bool> get isFormValidStream => _isFormValid.stream;

  void _validateForm() {
    _isFormValid.value = false;
  }

  UIError? _validateField({required String field, required String value}) {
    UIError? uiError;

    final error = validator.validate(field: field, value: value);

    switch (error) {
      case ValidatorError.invalidField:
        uiError = UIError.invalidField;
        break;
      case ValidatorError.requiredField:
        uiError = UIError.requiredField;
        break;
      default:
        uiError = null;
    }
    return uiError;
  }

  void validateName(String name) {
    _nameError.value = _validateField(
      field: GetxSignUpPresenter.nameFieldName,
      value: name,
    );
    _validateForm();
  }

  void validateEmail(String email) {
    _emailError.value = _validateField(
      field: GetxSignUpPresenter.emailFieldName,
      value: email,
    );
    _validateForm();
  }

  void validatePassword(String password) {
    _passwordError.value = _validateField(
      field: GetxSignUpPresenter.passwordFieldName,
      value: password,
    );
    _validateForm();
  }

  void validatePasswordConfirmation(String passwordConfirmation) {
    _passwordConfirmationError.value = _validateField(
      field: GetxSignUpPresenter.passwordConfirmationFieldName,
      value: passwordConfirmation,
    );
    _validateForm();
  }

  /*
  @override
  Future<void> auth() async {
    try {
      _isLoading.value = true;
      final account = await authentication.auth(AuthenticationParams(
        email: _email!,
        password: _password!,
      ));
      await saveCurrentAccount.save(account);
      _navigateTo.value = AppRoutes.surveys;
    } on DomainError catch (error) {
      _mainError.value = domainErrorToUIError(error);
      _isLoading.value = false;
    }
  }
*/

  // @override
  // void dispose() {
  //   super.dispose();
  // }
}
