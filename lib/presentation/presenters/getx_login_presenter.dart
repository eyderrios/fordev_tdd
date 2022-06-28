import 'package:get/get.dart';

import '../../domain/helpers/domain_error.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/pages/login/login_presenter.dart';
import '../protocols/validator.dart';

class GetxLoginPresenter extends GetxController implements LoginPresenter {
  static const emailFieldName = 'email';
  static const passwordFieldName = 'password';

  final Validator validator;
  final Authentication authentication;
  final SaveCurrentAccount? saveCurrentAccount;

  String? _email;
  String? _password;

  final Rx<String?> _emailError = Rx<String?>(null);
  final Rx<String?> _passwordError = Rx<String?>(null);
  final Rx<String?> _mainError = Rx<String?>(null);
  final _isFormValid = RxBool(false);
  final _isLoading = RxBool(false);

  GetxLoginPresenter({
    required this.validator,
    required this.authentication,
    required this.saveCurrentAccount,
  });

  @override
  Stream<String?> get emailErrorStream => _emailError.stream;

  @override
  Stream<String?> get passwordErrorStream => _passwordError.stream;

  @override
  Stream<String?> get mainErrorStream => _mainError.stream;

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

  @override
  void validateEmail(String email) {
    _email = email;
    _emailError.value = validator.validate(
      field: GetxLoginPresenter.emailFieldName,
      value: email,
    );
    _validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    _passwordError.value = validator.validate(
      field: GetxLoginPresenter.passwordFieldName,
      value: password,
    );
    _validateForm();
  }

  @override
  Future<void> auth() async {
    _isLoading.value = true;

    try {
      final account = await authentication.auth(AuthenticationParams(
        email: _email!,
        password: _password!,
      ));
      await saveCurrentAccount?.save(account);
    } on DomainError catch (error) {
      _mainError.value = error.description;
    }

    _isLoading.value = false;
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }
}
