import './translations.dart';

class EnUs implements Translations {
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
  String get password => 'Password';

  @override
  String get wait => 'Please wait';

  // DomainError
  @override
  String get invalidCredentialsError => 'Invalid credentials';

  @override
  String get unexpectedError => 'Unexpected error';
}
