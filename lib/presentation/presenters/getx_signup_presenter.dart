import 'package:get/get.dart';

import 'package:fordev_tdd/domain/helpers/domain_error.dart';

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
  final SaveCurrentAccount saveCurrentAccount;

  String? _name;
  String? _email;
  String? _password;
  String? _passwordConfirmation;

  final _nameError = Rx<UIError?>(null);
  final _emailError = Rx<UIError?>(null);
  final _passwordError = Rx<UIError?>(null);
  final _passwordConfirmationError = Rx<UIError?>(null);
  final _mainError = Rx<UIError?>(null);
  final _isFormValid = RxBool(false);
  final _isLoading = RxBool(false);

  GetxSignUpPresenter({
    required this.validator,
    required this.addAccount,
    required this.saveCurrentAccount,
  });

  Stream<UIError?> get mainErrorStream => _mainError.stream;
  Stream<UIError?> get nameErrorStream => _nameError.stream;
  Stream<UIError?> get emailErrorStream => _emailError.stream;
  Stream<UIError?> get passwordErrorStream => _passwordError.stream;
  Stream<UIError?> get passwordConfirmationErrorStream =>
      _passwordConfirmationError.stream;

  Stream<bool> get isFormValidStream => _isFormValid.stream;
  Stream<bool> get isLoadingStream => _isLoading.stream;

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
    try {
      _isLoading.value = true;
      final params = AddAccountParams(
        name: _name!,
        email: _email!,
        password: _password!,
        passwordConfirmation: _passwordConfirmation!,
      );
      final account = await addAccount.add(params);
      await saveCurrentAccount.save(account);
    } on DomainError catch (error) {
      _mainError.value = domainErrorToUIError(error);
      _isLoading.value = false;
    }
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }
}
