import '../../presentation/protocols/validator.dart';

typedef FieldInput = Map<String, dynamic>;

abstract class FieldValidator {
  String get field;

  ValidatorError? validate(FieldInput input);
}
