import 'package:test/test.dart';

import 'package:fordev_tdd/presentation/protocols/validator.dart';
import 'package:fordev_tdd/validation/validators/validators.dart';

void main() {
  const fieldName = 'field1_name';
  const rightValue = 'field_value';
  const wrongValue = 'field_wrong_value';
  late CompareFieldsValidator sut;

  setUp(() {
    sut = const CompareFieldsValidator(
        field: fieldName, valueToCompare: rightValue);
  });

  test('Should return error if values are not equal', () {
    expect(sut.validate(wrongValue), ValidatorError.invalidField);
  });

  test('Should return null if values are equal', () {
    expect(sut.validate(rightValue), isNull);
  });
}
