import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/presentation/protocols/protocols.dart';

class ValidationSpy extends Mock implements Validation {
  void mockValidation({String? field, String? value}) {
    when(() => validate(
          field: (field == null) ? any(named: 'field') : field,
          value: any(named: 'value'),
        )).thenReturn(value);
  }
}
