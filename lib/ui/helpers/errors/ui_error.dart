import 'package:fordev_tdd/domain/helpers/domain_error.dart';

import '../../../utils/i18n/i18n.dart';

enum UIError {
  requiredField,
  invalidField,
  invalidCredentials,
  unexpected,
  unknow,
}

extension UIErrorExtension on UIError {
  static final Map<UIError, String> _descriptions = {
    UIError.requiredField: R.strings.requiredField,
    UIError.invalidField: R.strings.invalidField,
    UIError.invalidCredentials: R.strings.invalidCredentialsError,
    UIError.unexpected: R.strings.unexpectedError,
  };

  String get description => _descriptions.containsKey(this)
      ? _descriptions[this]!
      : R.strings.unknowError;
}

UIError domainErrorToUIError(DomainError error) {
  UIError uiError;

  switch (error) {
    case DomainError.invalidCredentials:
      uiError = UIError.invalidCredentials;
      break;
    case DomainError.unexpected:
      uiError = UIError.unexpected;
      break;
    default:
      uiError = UIError.unknow;
  }
  return uiError;
}
