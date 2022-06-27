import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/validation/validators/validator_composite.dart';
import 'package:fordev_tdd/validation/validators/validators.dart';

import '../mocks/field_validator_spy.dart';

void main() {
  const fieldName = 'field_name';
  const fieldValue = 'field_value';
  late ValidatorComposite sut;
  late FieldValidatorSpy validator1;
  late FieldValidatorSpy validator2;

  setUp(() {
    validator1 = FieldValidatorSpy(fieldName, fieldValue);
    validator2 = FieldValidatorSpy(fieldName, null);

    sut = ValidatorComposite([
      validator1,
      validator2,
    ]);
  });

  test('Should return null if all validations returns null or empty', () {
    // Act
    final result = sut.validate(field: fieldName, value: fieldValue);
    // Assert
    expect(result, null);
  });
}
