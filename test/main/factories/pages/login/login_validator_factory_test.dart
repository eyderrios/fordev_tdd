import 'package:test/test.dart';

import 'package:fordev_tdd/validation/validators/validators.dart';
import 'package:fordev_tdd/main/factories/pages/login/login_validator_factory.dart';

void main() {
  test('Should return the correct validators', () {
    final validators = LoginValidatorFactory.makeLoginValidators();

    expect(validators, const [
      RequiredFieldValidator('email'),
      EmailValidator('email'),
      RequiredFieldValidator('password'),
    ]);
  });
}
