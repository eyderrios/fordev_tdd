import '../../ui/helpers/i18n/i18n.dart';

enum DomainError {
  unexpected,
  invalidCredentials,
}

extension DomainErrorExtension on DomainError {
  static final Map<DomainError, String> _descriptions = {
    DomainError.unexpected: R.strings.unexpectedError,
    DomainError.invalidCredentials: R.strings.invalidCredentialsError,
  };

  String get description => _descriptions[this]!;
}
