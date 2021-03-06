import 'package:test/test.dart';

import 'package:fordev_tdd/presentation/protocols/validator.dart';
import 'package:fordev_tdd/main/composites/validator_composite.dart';

import '../../validation/mocks/field_validator_spy.dart';

void main() {
  const input = {'some_field': 'some_value'};
  late ValidatorComposite sut;
  late FieldValidatorSpy validator1;
  late FieldValidatorSpy validator2;
  late FieldValidatorSpy validator3;

  setUp(() {
    validator1 = FieldValidatorSpy('field1_name');
    validator2 = FieldValidatorSpy('field1_name');
    validator3 = FieldValidatorSpy('field3_name');

    sut = ValidatorComposite([
      validator1,
      validator2,
      validator3,
    ]);
  });

  test('Should return null if all validators returns null or empty', () {
    final error = sut.validate(field: 'some_field', input: input);
    expect(error, isNull);
  });

  test('Should return the first error', () {
    // Arrange
    validator1.mockValidate(ValidatorError.requiredField);
    validator2.mockValidate(ValidatorError.requiredField);
    validator3.mockValidate(ValidatorError.invalidField);
    // Act
    final result = sut.validate(field: validator1.field, input: input);
    // Assert
    expect(result, ValidatorError.requiredField);
  });
}
