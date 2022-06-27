import 'package:test/test.dart';

import 'package:fordev_tdd/utils/i18n/resources.dart';
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
    final result = sut.validate(fieldValue);
    // Assert
    expect(result, null);
  });

  test('Should return error if value is empty', () {
    final error = R.strings.requiredField;
    // Act
    final result = sut.validate('');
    // Assert
    expect(result, error);
  });
}
