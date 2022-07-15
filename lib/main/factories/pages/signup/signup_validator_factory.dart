import '../../../builders/validator_builder.dart';
import '../../../../validation/protocols/protocols.dart';
import '../../../../presentation/protocols/protocols.dart';
import '../../../composites/validator_composite.dart';

class SignUpValidatorFactory {
  static Validator makeSignUpValidator() =>
      ValidatorComposite(makeSignUpValidators());

  static List<FieldValidator> makeSignUpValidators() => [
        ...ValidatorBuilder.field('name').requiredField().min(5).build(),
        ...ValidatorBuilder.field('email').requiredField().email().build(),
        ...ValidatorBuilder.field('password').requiredField().min(5).build(),
        ...ValidatorBuilder.field('passwordConfirmation')
            .requiredField()
            .sameAs('password')
            .build(),
      ];
}
