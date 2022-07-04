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
    final value1 = ignoreCase ? input[field] : input[field].toLowerCase();
    final value2 = ignoreCase
        ? input[fieldToCompare]
        : input[fieldToCompare].toLowerCase();
    return (value1 != value2) ? ValidatorError.invalidField : null;
  }
}
