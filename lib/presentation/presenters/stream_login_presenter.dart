import '../../ui/pages/login/login_presenter.dart';
import '../../validation/validators/validation.dart';

class StreamLoginPresenter implements LoginPresenter {
  final Validation validation;

  StreamLoginPresenter({required this.validation});

  @override
  Future<void> auth() {
    throw UnimplementedError();
  }

  @override
  void dispose() {}

  @override
  Stream<String> get emailErrorStream => throw UnimplementedError();

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
    validation.validate(field: 'email', value: email);
  }

  @override
  void validatePassword(String password) {}
}
