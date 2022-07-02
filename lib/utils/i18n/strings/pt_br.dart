import 'package:fordev_tdd/utils/i18n/strings/translations.dart';

import './translations.dart';

class PtBr implements Translations {
  //
  // Strings
  //
  @override
  String get appName => '4Dev';
  @override
  String get addAccount => 'Criar Conta';
  @override
  String get enter => 'entrar';
  @override
  String get email => 'E-mail';
  @override
  String get login => 'login';
  @override
  String get password => 'Senha';
  @override
  String get surveys => 'Enquetes';
  @override
  String get wait => 'Aguarde';
  //
  // DomainError
  //
  @override
  String get invalidCredentialsError => 'Credenciais inválidas';
  @override
  String get unexpectedError => 'Erro inesperado';
  @override
  String get unknowError => 'Erro desconhecido';
  //
  // Validators error messages
  //
  @override
  String get invalidField => 'Campo inválido';
  @override
  String get requiredField => 'Campo obrigatório';
}
