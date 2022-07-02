import 'dart:async';

import '../../domain/helpers/domain_error.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/helpers/errors/errors.dart';
import '../../ui/pages/login/login_presenter.dart';
import '../protocols/validator.dart';

class LoginState {
  String? email;
  String? password;

  UIError? emailError;
  UIError? passwordError;
  UIError? mainError;
  String? navigateTo;

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

  Stream<T> _mapStream<T>(T Function(LoginState state) convert) {
    if (_controller.isClosed) {
      return const Stream.empty();
    }
    return _controller.stream.map(convert).distinct();
  }

  @override
  Stream<UIError?> get emailErrorStream =>
      _mapStream((state) => state.emailError);

  @override
  Stream<UIError?> get passwordErrorStream =>
      _mapStream((state) => state.passwordError);

  @override
  Stream<UIError?> get mainErrorStream =>
      _mapStream((state) => state.mainError);

  @override
  Stream<String?> get navigateToStream =>
      _mapStream((state) => state.navigateTo);

  @override
  Stream<bool> get isFormValidStream =>
      _mapStream((state) => state.isFormValid);

  @override
  Stream<bool> get isLoadingStream => _mapStream((state) => state.isLoading);

  void _updateState() {
    if (!_controller.isClosed) {
      _controller.add(_state);
    }
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

  @override
  void validateEmail(String email) {
    _state.email = email;
    _state.emailError = _validateField(
      field: StreamLoginPresenter.emailFieldName,
      value: email,
    );
    _updateState();
  }

  @override
  void validatePassword(String password) {
    _state.password = password;
    _state.passwordError = _validateField(
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
      _state.mainError = domainErrorToUIError(error);
    }

    _state.isLoading = false;
    _updateState();
  }

  @override
  void dispose() {
    _controller.close();
  }
}
