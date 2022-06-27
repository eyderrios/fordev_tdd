import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/validation/protocols/field_validator.dart';

class FieldValidatorSpy extends Mock implements FieldValidator {
  FieldValidatorSpy(String fieldName) {
    mockField(fieldName);
    mockValidate(null);
  }

  void mockField(String fieldName) => when(() => field).thenReturn(fieldName);

  void mockValidate(String? fieldValue) =>
      when(() => validate(any())).thenReturn(fieldValue);
}
