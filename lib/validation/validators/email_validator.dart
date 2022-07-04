import 'package:equatable/equatable.dart';

import '../../presentation/protocols/validator.dart';
import '../protocols/field_validator.dart';

class EmailValidator extends Equatable implements FieldValidator {
  static final _regex = RegExp(
      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");

  @override
  final String field;

  const EmailValidator(this.field);

  @override
  List<Object?> get props => [field];

  @override
  ValidatorError? validate(String value) {
    return (value.isNotEmpty && !_regex.hasMatch(value))
        ? ValidatorError.invalidField
        : null;
  }
}
