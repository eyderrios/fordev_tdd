import 'dart:async';

import '../../ui/pages/login/login_presenter.dart';
import '../protocols/validator.dart';

class LoginState {
  String? emailError;
  String? passwordError;

  bool get isFormValid => false;
}

class StreamLoginPresenter implements LoginPresenter {
  static const emailFieldName = 'email';
  static const passwordFieldName = 'password';

  final _state = LoginState();
  final _controller = StreamController<LoginState>.broadcast();

  final Validator validator;

  StreamLoginPresenter({required this.validator});

  @override
  Future<void> auth() {
    throw UnimplementedError();
  }

  @override
  void dispose() {}

  @override
  Stream<String?> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError).distinct();

  @override
  Stream<String?> get passwordErrorStream =>
      _controller.stream.map((state) => state.passwordError).distinct();

  @override
  Stream<bool> get isFormValidStream =>
      _controller.stream.map((state) => state.isFormValid).distinct();

  @override
  Stream<bool> get isLoadingStream => throw UnimplementedError();

  @override
  Stream<String> get mainErrorStream => throw UnimplementedError();

  void _updatestate() => _controller.add(_state);

  @override
  void validateEmail(String email) {
    _state.emailError = validator.validate(
      field: StreamLoginPresenter.emailFieldName,
      value: email,
    );
    _updatestate();
  }

  @override
  void validatePassword(String password) {
    _state.passwordError = validator.validate(
      field: StreamLoginPresenter.passwordFieldName,
      value: password,
    );
    _updatestate();
  }
}
