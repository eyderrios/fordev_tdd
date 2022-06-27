import './protocols/field_validator.dart';

class EmailValidator implements FieldValidator {
  final String _field;

  EmailValidator(String field) : _field = field;

  @override
  String get field => _field;

  @override
  String? validate(String value) {
    return null;
  }
}
