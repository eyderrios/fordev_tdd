import '../../../builders/validator_builder.dart';
import '../../../../validation/protocols/protocols.dart';
import '../../../../presentation/protocols/protocols.dart';
import '../../../composites/validator_composite.dart';

class LoginValidatorFactory {
  static Validator makeLoginValidator() =>
      ValidatorComposite(makeLoginValidators());

  static List<FieldValidator> makeLoginValidators() => [
        ...ValidatorBuilder.field('email').requiredField().email().build(),
        ...ValidatorBuilder.field('password').requiredField().min(5).build(),
        ...ValidatorBuilder.field('passwordConfirmation')
            .requiredField()
            .sameAs('password')
            .build(),
      ];
}
