import '../../presentation/protocols/validator.dart';
import '../protocols/field_validator.dart';

class ValidatorComposite implements Validator {
  final List<FieldValidator> validators;

  ValidatorComposite(this.validators);

  @override
  ValidatorError? validate({
    required String field,
    required ValidatorFieldInput input,
  }) {
    ValidatorError? error;

    for (var validator in validators.where((val) => val.field == field)) {
      error = validator.validate(input);
      if (error != null) {
        return error;
      }
    }
    return null;
  }
}
