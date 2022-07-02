import '../../presentation/protocols/validator.dart';

abstract class FieldValidator {
  String get field;

  ValidatorError? validate(String value);
}
