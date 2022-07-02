import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

abstract class AddAccount {
  Future<AccountEntity> add(AddAccountParams params);
}

class AddAccountParams extends Equatable {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  const AddAccountParams(
    this.name,
    this.email,
    this.password,
    this.passwordConfirmation,
  );

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        passwordConfirmation,
      ];

  @override
  String toString() => 'AddAccountParams("$name","$email","$password")';
}
