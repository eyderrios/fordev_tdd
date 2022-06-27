import '../../../../presentation/protocols/protocols.dart';
import '../../../../validation/validators/validators.dart';

class LoginValidatorFactory {
  static Validator makeLoginValidator() => ValidatorComposite([
        RequiredFieldValidator('email'),
        EmailValidator('email'),
        RequiredFieldValidator('password'),
      ]);
}
