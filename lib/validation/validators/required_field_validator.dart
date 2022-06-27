import '../../utils/i18n/resources.dart';
import '../protocols/protocols.dart';

class RequiredFieldValidator implements FieldValidator {
  final String _field;

  RequiredFieldValidator(String field) : _field = field;

  @override
  String get field => _field;

  @override
  String? validate(String value) {
    return value.isEmpty ? R.strings.requiredField : null;
  }
}
