import 'package:get/get.dart';

import '../../domain/usecases/usecases.dart';
import '../../ui/helpers/errors/errors.dart';
import '../protocols/validator.dart';

class GetxSignUpPresenter extends GetxController {
  static const nameFieldName = 'name';
  static const emailFieldName = 'email';
  static const passwordFieldName = 'password';
  static const passwordConfirmationFieldName = 'passwordConfirmation';

  final Validator validator;
  final AddAccount addAccount;

  String? _name;
  String? _email;
  String? _password;
  String? _passwordConfirmation;

  final _nameError = Rx<UIError?>(null);
  final _emailError = Rx<UIError?>(null);
  final _passwordError = Rx<UIError?>(null);
  final _passwordConfirmationError = Rx<UIError?>(null);
  final _isFormValid = RxBool(false);

  GetxSignUpPresenter({
    required this.validator,
    required this.addAccount,
  });

  Stream<UIError?> get nameErrorStream => _nameError.stream;
  Stream<UIError?> get emailErrorStream => _emailError.stream;
  Stream<UIError?> get passwordErrorStream => _passwordError.stream;
  Stream<UIError?> get passwordConfirmationErrorStream =>
      _passwordConfirmationError.stream;

  Stream<bool> get isFormValidStream => _isFormValid.stream;

  void _validateForm() {
    _isFormValid.value = (_name != null) &&
        (_nameError.value == null) &&
        (_email != null) &&
        (_emailError.value == null) &&
        (_password != null) &&
        (_passwordError.value == null) &&
        (_passwordConfirmation != null) &&
        (_passwordConfirmationError.value == null);
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
    _name = name;
    _nameError.value = _validateField(
      field: GetxSignUpPresenter.nameFieldName,
      value: name,
    );
    _validateForm();
  }

  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField(
      field: GetxSignUpPresenter.emailFieldName,
      value: email,
    );
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField(
      field: GetxSignUpPresenter.passwordFieldName,
      value: password,
    );
    _validateForm();
  }

  void validatePasswordConfirmation(String passwordConfirmation) {
    _passwordConfirmation = passwordConfirmation;
    _passwordConfirmationError.value = _validateField(
      field: GetxSignUpPresenter.passwordConfirmationFieldName,
      value: passwordConfirmation,
    );
    _validateForm();
  }

  Future<void> signUp() async {
    final params = AddAccountParams(
      name: _name!,
      email: _email!,
      password: _password!,
      passwordConfirmation: _passwordConfirmation!,
    );
    addAccount.add(params);
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }
}
