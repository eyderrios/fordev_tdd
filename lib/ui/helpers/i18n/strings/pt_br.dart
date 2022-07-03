import 'translations.dart';

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
  String get login => 'Login';
  @override
  String get name => 'Nome';
  @override
  String get password => 'Senha';
  @override
  String get passwordConfirmation => 'Confirmação de senha';
  @override
  String get signUp => 'Registrar';
  @override
  String get surveys => 'Enquetes';
  @override
  String get wait => 'Aguarde';
  //
  // DomainError
  //
  @override
  String get emailInUseError => 'E-mail em uso';
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
