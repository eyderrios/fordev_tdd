import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/validation/validators/validation.dart';

class ValidationSpy extends Mock implements Validation {
  void mockValidate(String? error) {
    when(() => validate(field: any(named: 'field'), value: any(named: 'value')))
        .thenReturn(error);
  }
}
