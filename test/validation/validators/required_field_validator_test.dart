import 'package:fordev_tdd/presentation/protocols/validator.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/validation/validators/validators.dart';

void main() {
  const fieldName = 'field_name';
  const fieldValue = 'field_value';
  late RequiredFieldValidator sut;

  setUp(() {
    sut = const RequiredFieldValidator(fieldName);
  });

  test('Should return null on invalid case', () {
    expect(sut.validate({}), isNull);
  });

  test('Should return null if value is not empty', () {
    // Act
    final result = sut.validate({fieldName: fieldValue});
    // Assert
    expect(result, null);
  });

  test('Should return error if value is empty', () {
    // Act
    final result = sut.validate({fieldName: ''});
    // Assert
    expect(result, ValidatorError.requiredField);
  });
}
