import 'package:fordev_tdd/validation/protocols/field_validator.dart';

import '../../presentation/protocols/validator.dart';

class ValidatorComposite implements Validator {
  final List<FieldValidator> validators;

  ValidatorComposite(this.validators);

  @override
  String? validate({required String field, required String value}) {
    return null;
  }
}
