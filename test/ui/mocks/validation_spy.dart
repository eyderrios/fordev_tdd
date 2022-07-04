import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/presentation/protocols/protocols.dart';

class ValidationSpy extends Mock implements Validator {
  void mockValidate({String? field, required ValidatorError? value}) {
    when(() => validate(
          field: (field == null) ? any(named: 'field') : field,
          input: any(named: 'input'),
        )).thenReturn(value);
  }
}
