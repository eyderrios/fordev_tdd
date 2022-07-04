import 'package:test/test.dart';

import 'package:fordev_tdd/validation/validators/validators.dart';
import 'package:fordev_tdd/main/factories/factories.dart';

void main() {
  test('Should return the correct validators', () {
    final validators = SignUpValidatorFactory.makeSignUpValidators();

    expect(validators, const [
      RequiredFieldValidator('name'),
      MinLengthValidator(field: 'name', minLength: 5),
      RequiredFieldValidator('email'),
      EmailValidator('email'),
      RequiredFieldValidator('password'),
      MinLengthValidator(field: 'password', minLength: 5),
      RequiredFieldValidator('passwordConfirmation'),
      CompareFieldsValidator(
          field: 'passwordConfirmation', fieldToCompare: 'password'),
    ]);
  });
}
