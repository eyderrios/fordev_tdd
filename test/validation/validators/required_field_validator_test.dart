import 'package:test/test.dart';

import 'package:fordev_tdd/validation/validators/validators.dart';

void main() {
  const fieldName = 'field_name';
  const fieldValue = 'field_value';
  late RequiredFieldValidator sut;

  setUp(() {
    sut = RequiredFieldValidator(fieldName);
  });

  test('Should return null if value is not empty', () {
    // Act
    final error = sut.validate(fieldValue);
    // Assert
    expect(error, null);
  });

  test('Should return error if value is empty', () {
    // Act
    final error = sut.validate('');
    // Assert
    expect(error, 'Required field');
  });
}
