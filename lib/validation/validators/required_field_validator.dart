import './protocols/protocols.dart';

class RequiredFieldValidator implements FieldValidator {
  final String _field;

  RequiredFieldValidator(String field) : _field = field;

  @override
  String get field => _field;

  @override
  String? validate(String value) {
    return value.isEmpty ? 'Required field' : null;
  }
}
