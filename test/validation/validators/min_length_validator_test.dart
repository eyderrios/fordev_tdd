import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/presentation/protocols/validator.dart';
import 'package:fordev_tdd/validation/validators/min_length_validator.dart';

void main() {
  const fieldName = 'field_name';
  const fieldLength = 5;
  late MinLengthValidator sut;

  setUp(() {
    sut = const MinLengthValidator(field: fieldName, minLength: fieldLength);
  });

  test('Should return null on invalid case', () {
    expect(sut.validate({}), isNull);
  });

  test('Should return error if value is empty', () {
    expect(sut.validate({fieldName: ''}), ValidatorError.invalidField);
  });

  test('Should return error if value length is less than minLength', () {
    final value = faker.randomGenerator.string(fieldLength - 1, min: 1);
    expect(sut.validate({fieldName: value}), ValidatorError.invalidField);
  });

  test('Should return error if value length is equal to minLength', () {
    final value = faker.randomGenerator.string(fieldLength, min: fieldLength);
    expect(sut.validate({fieldName: value}), isNull);
  });

  test('Should return error if value length is greater than minLength', () {
    final value =
        faker.randomGenerator.string(2 * fieldLength, min: fieldLength + 1);
    expect(sut.validate({fieldName: value}), isNull);
  });
}
