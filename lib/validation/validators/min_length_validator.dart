import 'package:equatable/equatable.dart';

import '../../presentation/protocols/validator.dart';
import '../protocols/field_validator.dart';

class MinLengthValidator extends Equatable implements FieldValidator {
  @override
  final String field;
  final int minLength;

  const MinLengthValidator({required this.field, required this.minLength});

  @override
  List<Object?> get props => [
        field,
        minLength,
      ];

  @override
  ValidatorError? validate(FieldInput input) {
    return (input[field].length < minLength)
        ? ValidatorError.invalidField
        : null;
  }
}
