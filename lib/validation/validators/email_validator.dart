import 'package:equatable/equatable.dart';

import '../../utils/i18n/resources.dart';
import '../protocols/field_validator.dart';

class EmailValidator extends Equatable implements FieldValidator {
  static final regex = RegExp(
      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");

  final String _field;

  const EmailValidator(String field) : _field = field;

  @override
  String get field => _field;

  @override
  List<Object?> get props => [_field];

  @override
  String? validate(String value) {
    return (value.isNotEmpty && !regex.hasMatch(value))
        ? R.strings.invalidField
        : null;
  }
}
