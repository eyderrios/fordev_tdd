enum DomainError {
  unexpected,
  invalidCredentials,
}

extension DomainErrorExtension on DomainError {
  static const Map<DomainError, String> _descriptions = {
    DomainError.unexpected: 'Unexected error',
    DomainError.invalidCredentials: 'Invalid credentials',
  };

  String get description => _descriptions[this]!;
}
