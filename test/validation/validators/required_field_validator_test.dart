import 'package:test/test.dart';

import 'package:fordev_tdd/validation/validators/required_field_validator.dart';

void main() {
  const fieldName = 'field_name';
  const fieldValue = 'field_value';

  test('Should return null if value is nor empty', () {
    final sut = RequiredFieldValidator(fieldName);

    final error = sut.validate(fieldValue);

    expect(error, null);
  });
}
