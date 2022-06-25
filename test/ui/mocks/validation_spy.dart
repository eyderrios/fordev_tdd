import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/validation/validators/validation.dart';

class ValidationSpy extends Mock implements Validation {
  ValidationSpy() {
    _mockMethods();
  }

  void _mockMethods() {
    when(() => validate(field: any(named: 'field'), value: any(named: 'value')))
        .thenReturn(null);
  }
}
