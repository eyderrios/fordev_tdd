import 'package:test/test.dart';

import 'package:fordev_tdd/presentation/protocols/validator.dart';
import 'package:fordev_tdd/validation/validators/validators.dart';

void main() {
  const field1Name = 'field1_name';
  const field2Name = 'field2_name';
  const someValue = 'some_value';
  const otherValue = 'other_value';
  late CompareFieldsValidator sut;

  setUp(() {
    sut = const CompareFieldsValidator(
        field: field1Name, fieldToCompare: field2Name);
  });

  test('Should return error if values are not equal', () {
    final input = {
      field1Name: someValue,
      field2Name: otherValue,
    };
    expect(sut.validate(input), ValidatorError.invalidField);
  });

  test('Should return null if values are equal', () {
    final input = {
      field1Name: someValue,
      field2Name: someValue,
    };
    expect(sut.validate(input), isNull);
  });
}
