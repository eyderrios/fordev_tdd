import 'package:equatable/equatable.dart';
import 'package:fordev_tdd/presentation/protocols/validator.dart';

import '../protocols/protocols.dart';

class RequiredFieldValidator extends Equatable implements FieldValidator {
  final String _field;

  const RequiredFieldValidator(String field) : _field = field;

  @override
  String get field => _field;

  @override
  ValidatorError? validate(String value) {
    return value.isEmpty ? ValidatorError.requiredField : null;
  }

  @override
  List<Object?> get props => [_field];
}
