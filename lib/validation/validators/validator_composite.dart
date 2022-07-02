import 'package:fordev_tdd/validation/protocols/field_validator.dart';

import '../../presentation/protocols/validator.dart';

class ValidatorComposite implements Validator {
  final List<FieldValidator> validators;

  ValidatorComposite(this.validators);

  @override
  ValidatorError? validate({required String field, required String value}) {
    ValidatorError? error;

    for (var validator in validators.where((val) => val.field == field)) {
      error = validator.validate(value);
      if (error != null) {
        return error;
      }
    }
    return null;
  }
}
