import 'package:fordev_tdd/validation/validators/field_validator.dart';

class RequiredFieldValidator implements FieldValidator {
  final String _field;

  RequiredFieldValidator(String field) : _field = field;

  @override
  String get field => _field;

  @override
  String? validate(String value) {
    return null;
  }
}
