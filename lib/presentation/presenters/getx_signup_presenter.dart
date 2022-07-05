import 'package:fordev_tdd/ui/pages/pages.dart';
import 'package:get/get.dart';

import 'package:fordev_tdd/domain/helpers/domain_error.dart';

import '../../domain/usecases/usecases.dart';
import '../../main/apps/app_routes.dart';
import '../../ui/helpers/errors/errors.dart';
import '../protocols/validator.dart';

class GetxSignUpPresenter extends GetxController implements SignUpPresenter {
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
  final _navigateTo = Rx<String?>(null);
  final _isFormValid = RxBool(false);
  final _isLoading = RxBool(false);

  GetxSignUpPresenter({
    required this.validator,
    required this.addAccount,
    required this.saveCurrentAccount,
  });

  @override
  Stream<UIError?> get mainErrorStream => _mainError.stream;
  @override
  Stream<UIError?> get nameErrorStream => _nameError.stream;
  @override
  Stream<UIError?> get emailErrorStream => _emailError.stream;
  @override
  Stream<UIError?> get passwordErrorStream => _passwordError.stream;
  @override
  Stream<UIError?> get passwordConfirmationErrorStream =>
      _passwordConfirmationError.stream;
  @override
  Stream<bool> get isFormValidStream => _isFormValid.stream;
  @override
  Stream<bool> get isLoadingStream => _isLoading.stream;
  @override
  Stream<String?> get navigateToStream => _navigateTo.stream;

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

  UIError? _validateField(String field) {
    UIError? uiError;
    final formData = {
      nameFieldName: _name,
      emailFieldName: _email,
      passwordFieldName: _password,
      passwordConfirmationFieldName: _passwordConfirmation,
    };
    final error = validator.validate(field: field, input: formData);

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

  @override
  void validateName(String name) {
    _name = name;
    _nameError.value = _validateField(GetxSignUpPresenter.nameFieldName);
    _validateForm();
  }

  @override
  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField(GetxSignUpPresenter.emailFieldName);
    _validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    _passwordError.value =
        _validateField(GetxSignUpPresenter.passwordFieldName);
    _validateForm();
  }

  @override
  void validatePasswordConfirmation(String passwordConfirmation) {
    _passwordConfirmation = passwordConfirmation;
    _passwordConfirmationError.value =
        _validateField(GetxSignUpPresenter.passwordConfirmationFieldName);
    _validateForm();
  }

  @override
  void goToLogin() {
    _navigateTo.value = AppRoutes.login;
  }

  @override
  Future<void> signUp() async {
    try {
      _mainError.value = null;
      _isLoading.value = true;
      final params = AddAccountParams(
        name: _name!,
        email: _email!,
        password: _password!,
        passwordConfirmation: _passwordConfirmation!,
      );
      final account = await addAccount.add(params);
      await saveCurrentAccount.save(account);
      _navigateTo.value = AppRoutes.surveys;
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
