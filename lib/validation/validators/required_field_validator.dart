import 'package:equatable/equatable.dart';
import 'package:fordev_tdd/presentation/protocols/validator.dart';

import '../protocols/protocols.dart';

class RequiredFieldValidator extends Equatable implements FieldValidator {
  final String _field;

  const RequiredFieldValidator(String field) : _field = field;

  @override
  String get field => _field;

  @override
  List<Object?> get props => [_field];

  @override
  ValidatorError? validate(FieldInput input) {
    return (input.containsKey(field) && input[field].isEmpty)
        ? ValidatorError.requiredField
        : null;
  }
}
