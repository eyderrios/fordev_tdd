import 'dart:async';

import '../../domain/helpers/domain_error.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/pages/login/login_presenter.dart';
import '../protocols/validator.dart';

class LoginState {
  String? email;
  String? password;

  String? emailError;
  String? passwordError;
  String? mainError;

  bool isLoading = false;

  bool get isFormValid =>
      (email != null) &&
      (emailError == null) &&
      (password != null) &&
      (passwordError == null);
}

class StreamLoginPresenter implements LoginPresenter {
  static const emailFieldName = 'email';
  static const passwordFieldName = 'password';

  final _state = LoginState();
  final _controller = StreamController<LoginState>.broadcast();

  final Validator validator;
  final Authentication authentication;

  StreamLoginPresenter({
    required this.validator,
    required this.authentication,
  });

  @override
  void dispose() {}

  @override
  Stream<String?> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError).distinct();

  @override
  Stream<String?> get passwordErrorStream =>
      _controller.stream.map((state) => state.passwordError).distinct();

  @override
  Stream<String?> get mainErrorStream =>
      _controller.stream.map((state) => state.mainError).distinct();

  @override
  Stream<bool> get isFormValidStream =>
      _controller.stream.map((state) => state.isFormValid).distinct();

  @override
  Stream<bool> get isLoadingStream =>
      _controller.stream.map((state) => state.isLoading).distinct();

  void _updateState() => _controller.add(_state);

  @override
  void validateEmail(String email) {
    _state.email = email;
    _state.emailError = validator.validate(
      field: StreamLoginPresenter.emailFieldName,
      value: email,
    );
    _updateState();
  }

  @override
  void validatePassword(String password) {
    _state.password = password;
    _state.passwordError = validator.validate(
      field: StreamLoginPresenter.passwordFieldName,
      value: password,
    );
    _updateState();
  }

  @override
  Future<void> auth() async {
    _state.isLoading = true;
    _updateState();

    try {
      await authentication.auth(AuthenticationParams(
        email: _state.email!,
        password: _state.password!,
      ));
    } on DomainError catch (error) {
      _state.mainError = error.description;
    }

    _state.isLoading = false;
    _updateState();
  }
}
