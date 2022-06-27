import '../../../../validation/protocols/protocols.dart';
import '../../../../presentation/protocols/protocols.dart';
import '../../../../validation/validators/validators.dart';

class LoginValidatorFactory {
  static Validator makeLoginValidator() =>
      ValidatorComposite(makeLoginValidators());

  static List<FieldValidator> makeLoginValidators() => const [
        RequiredFieldValidator('email'),
        EmailValidator('email'),
        RequiredFieldValidator('password'),
      ];
}
