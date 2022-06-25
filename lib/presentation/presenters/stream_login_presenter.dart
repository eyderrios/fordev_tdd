import 'dart:async';

import 'package:flutter/material.dart';

import '../../ui/pages/login/login_presenter.dart';
import '../protocols/validation.dart';

class LoginState {
  String? emailError;
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
  Stream<bool> get isFormValidStream => throw UnimplementedError();

  @override
  Stream<bool> get isLoadingStream => throw UnimplementedError();

  @override
  Stream<String> get mainErrorStream => throw UnimplementedError();

  @override
  Stream<String> get passwordErrorStream => throw UnimplementedError();

  @override
  void validateEmail(String email) {
    _state.emailError = validation.validate(field: 'email', value: email);
    debugPrint('_state: ${_state.emailError}, value: $email');
    _controller.add(_state);
  }

  @override
  void validatePassword(String password) {}
}
