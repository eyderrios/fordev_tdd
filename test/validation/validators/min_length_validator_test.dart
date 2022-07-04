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

  test('Should return error if value is empty', () {
    expect(sut.validate(''), ValidatorError.invalidField);
  });

  test('', () {
    //
  });
}
