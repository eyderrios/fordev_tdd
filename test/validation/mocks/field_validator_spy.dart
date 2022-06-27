import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/validation/protocols/field_validator.dart';

class FieldValidatorSpy extends Mock implements FieldValidator {
  FieldValidatorSpy(String fieldName, String? fieldValue) {
    _mockMethods(fieldName, fieldValue);
  }

  void _mockMethods(String fieldName, String? fieldValue) {
    when(() => field).thenReturn(fieldName);
    when(() => validate(any())).thenReturn(fieldValue);
  }
}
