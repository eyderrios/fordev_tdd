import './translations.dart';

class EnUs implements Translations {
  //
  // Strings
  //
  @override
  String get appName => '4Dev';
  @override
  String get addAccount => 'Create Account';
  @override
  String get email => 'E-mail';
  @override
  String get enter => 'enter';
  @override
  String get login => 'login';
  @override
  String get name => 'Name';
  @override
  String get password => 'Password';
  @override
  String get passwordConfirmation => 'Password confirmation';
  @override
  String get signUp => 'Sign Up';
  @override
  String get surveys => 'Surveys';
  @override
  String get wait => 'Please wait';
  //
  // DomainError messages
  //
  @override
  String get emailInUseError => 'E-mail in use';
  @override
  String get invalidCredentialsError => 'Invalid credentials';
  @override
  String get unexpectedError => 'Unexpected error';
  @override
  String get unknowError => 'Unknow error';
  //
  // Validators error messsages
  //
  @override
  String get invalidField => 'Invalid field';
  @override
  String get requiredField => 'Required field';
}
