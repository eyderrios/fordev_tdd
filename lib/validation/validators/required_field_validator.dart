import 'package:equatable/equatable.dart';

import '../../utils/i18n/resources.dart';
import '../protocols/protocols.dart';

class RequiredFieldValidator extends Equatable implements FieldValidator {
  final String _field;

  const RequiredFieldValidator(String field) : _field = field;

  @override
  String get field => _field;

  @override
  String? validate(String value) {
    return value.isEmpty ? R.strings.requiredField : null;
  }

  @override
  List<Object?> get props => [_field];
}
