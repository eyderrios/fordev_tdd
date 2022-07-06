import '../../ui/helpers/i18n/i18n.dart';

enum DomainError {
  unexpected,
  invalidCredentials,
  emailInUse,
  accessDenied,
}

extension DomainErrorExtension on DomainError {
  static final Map<DomainError, String> _descriptions = {
    DomainError.unexpected: R.strings.unexpectedError,
    DomainError.invalidCredentials: R.strings.invalidCredentialsError,
    DomainError.emailInUse: R.strings.emailInUseError,
    DomainError.accessDenied: R.strings.accessDeniedError,
  };

  String get description => _descriptions.containsKey(this)
      ? _descriptions[this]!
      : R.strings.unknowError;
}
