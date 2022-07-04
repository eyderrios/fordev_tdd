import 'package:get/get.dart';

import '../../ui/helpers/errors/errors.dart';
import '../protocols/validator.dart';

class GetxSignUpPresenter extends GetxController {
  static const emailFieldName = 'email';
  static const passwordFieldName = 'password';

  final Validator validator;

  final _emailError = Rx<UIError?>(null);
  final _isFormValid = RxBool(false);

  GetxSignUpPresenter({
    required this.validator,
  });

  Stream<UIError?> get emailErrorStream => _emailError.stream;

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

  void validateEmail(String email) {
    _emailError.value = _validateField(
      field: GetxSignUpPresenter.emailFieldName,
      value: email,
    );
    _validateForm();
  }
/*
  @override
  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField(
      field: GetxLoginPresenter.passwordFieldName,
      value: password,
    );
    _validateForm();
  }

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
