import 'package:fordev_tdd/main/apps/app_routes.dart';
import 'package:get/get.dart';

import '../../domain/helpers/domain_error.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/helpers/errors/errors.dart';
import '../../ui/pages/login/login_presenter.dart';
import '../protocols/validator.dart';

class GetxLoginPresenter extends GetxController implements LoginPresenter {
  static const emailFieldName = 'email';
  static const passwordFieldName = 'password';

  final Validator validator;
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccount;

  String? _email;
  String? _password;

  final _emailError = Rx<UIError?>(null);
  final _passwordError = Rx<UIError?>(null);
  final _mainError = Rx<UIError?>(null);
  final _navigateTo = Rx<String?>(null);
  final _isFormValid = RxBool(false);
  final _isLoading = RxBool(false);

  GetxLoginPresenter({
    required this.validator,
    required this.authentication,
    required this.saveCurrentAccount,
  });

  @override
  Stream<UIError?> get emailErrorStream => _emailError.stream;

  @override
  Stream<UIError?> get passwordErrorStream => _passwordError.stream;

  @override
  Stream<UIError?> get mainErrorStream => _mainError.stream;

  @override
  Stream<String?> get navigateToStream => _navigateTo.stream;

  @override
  Stream<bool> get isFormValidStream => _isFormValid.stream;

  @override
  Stream<bool> get isLoadingStream => _isLoading.stream;

  void _validateForm() {
    _isFormValid.value = (_email != null) &&
        (_emailError.value == null) &&
        (_password != null) &&
        (_passwordError.value == null);
  }

  UIError? _validateField(String field) {
    UIError? uiError;
    final formData = {
      emailFieldName: _email,
      passwordFieldName: _password,
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
  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField(GetxLoginPresenter.emailFieldName);
    _validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField(GetxLoginPresenter.passwordFieldName);
    _validateForm();
  }

  @override
  Future<void> auth() async {
    try {
      _mainError.value = null;
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

  @override
  void goToSignUp() {
    _navigateTo.value = AppRoutes.signUp;
  }

  // @override
  // void dispose() {}
}
