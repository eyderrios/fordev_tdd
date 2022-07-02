import 'package:faker/faker.dart';
import 'package:fordev_tdd/presentation/protocols/validator.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/validation/validators/validators.dart';

void main() {
  const fieldName = 'email';
  final email = faker.internet.email();
  late EmailValidator sut;

  setUp(() {
    sut = const EmailValidator(fieldName);
  });

  test('Should return null if email is empty', () {
    // Act
    final error = sut.validate('');
    // Assert
    expect(error, null);
  });

  test('Should return null if email is valid', () {
    // Act
    final error = sut.validate(email);
    // Assert
    expect(error, null);
  });

  test('Should return error if email is invalid', () {
    // Act
    final error = sut.validate('user.name');
    // Assert
    expect(error, ValidatorError.invalidField);
  });
}
