import 'package:equatable/equatable.dart';

import '../../presentation/protocols/validator.dart';
import '../protocols/field_validator.dart';

class CompareFieldsValidator extends Equatable implements FieldValidator {
  @override
  final String field;
  final String valueToCompare;
  final bool ignoreCase;

  const CompareFieldsValidator({
    required this.field,
    required this.valueToCompare,
    this.ignoreCase = false,
  });

  @override
  List<Object?> get props => [field];

  @override
  ValidatorError? validate(String value) {
    final value1 = ignoreCase ? valueToCompare : valueToCompare.toLowerCase();
    final value2 = ignoreCase ? value : value.toLowerCase();
    return (value1 != value2) ? ValidatorError.invalidField : null;
  }
}
