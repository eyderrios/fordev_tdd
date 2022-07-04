import 'package:equatable/equatable.dart';

import '../../presentation/protocols/validator.dart';
import '../protocols/field_validator.dart';

class CompareFieldsValidator extends Equatable implements FieldValidator {
  @override
  final String field;
  final String fieldToCompare;
  final bool ignoreCase;

  const CompareFieldsValidator({
    required this.field,
    required this.fieldToCompare,
    this.ignoreCase = false,
  });

  @override
  List<Object?> get props => [
        field,
        fieldToCompare,
        ignoreCase,
      ];

  @override
  ValidatorError? validate(FieldInput input) {
    final value1 = input.containsKey(field)
        ? ignoreCase
            ? input[field]
            : input[field].toLowerCase()
        : null;
    final value2 = input.containsKey(fieldToCompare)
        ? ignoreCase
            ? input[fieldToCompare]
            : input[fieldToCompare].toLowerCase()
        : null;

    return ((value1 == null) && (value2 == null)) || (value1 != value2)
        ? ValidatorError.invalidField
        : null;
  }
}
