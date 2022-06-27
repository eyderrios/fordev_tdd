import 'package:test/test.dart';

import 'package:fordev_tdd/validation/validators/validator_composite.dart';

import '../mocks/field_validator_spy.dart';

void main() {
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

  test('Should return null if all validations returns null or empty', () {
    // Arrange
    validator2.mockValidate('');
    // Act
    final result = sut.validate(field: 'field1_name', value: 'some_value');
    // Assert
    expect(result, null);
  });

  test('Should return the first error', () {
    // Arrange
    validator1.mockValidate('error1_message');
    validator2.mockValidate('error2_message');
    validator3.mockValidate('error3_message');
    // Act
    final result = sut.validate(field: 'field1_name', value: 'some_value');
    // Assert
    expect(result, 'error1_message');
  });
}
