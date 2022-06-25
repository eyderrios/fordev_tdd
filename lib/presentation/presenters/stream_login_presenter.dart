import 'dart:async';

import 'package:flutter/material.dart';

import '../../ui/pages/login/login_presenter.dart';
import '../protocols/validation.dart';

class LoginState {
  String? emailError;
  String? passwordError;

  bool get isFormValid => false;
}

class StreamLoginPresenter implements LoginPresenter {
  final Validation validation;
  final _controller = StreamController<LoginState>.broadcast();
  final _state = LoginState();

  StreamLoginPresenter({required this.validation});

  @override
  Future<void> auth() {
    throw UnimplementedError();
  }

  @override
  void dispose() {}

  @override
  Stream<String> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError ?? '').distinct();

  @override
  Stream<bool> get isFormValidStream =>
      _controller.stream.map((state) => state.isFormValid).distinct();

  @override
  Stream<String> get passwordErrorStream =>
      _controller.stream.map((state) => state.passwordError ?? '').distinct();

  @override
  Stream<bool> get isLoadingStream => throw UnimplementedError();

  @override
  Stream<String> get mainErrorStream => throw UnimplementedError();

  void _updatestate() => _controller.add(_state);

  @override
  void validateEmail(String email) {
    _state.emailError = validation.validate(field: 'email', value: email);
    _updatestate();
  }

  @override
  void validatePassword(String password) {
    _state.passwordError =
        validation.validate(field: 'password', value: password);
    _updatestate();
  }
}
