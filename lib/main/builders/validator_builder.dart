import '../../validation/protocols/protocols.dart';
import '../../validation/validators/validators.dart';

class ValidatorBuilder {
  static late ValidatorBuilder _instance;

  String fieldName;
  List<FieldValidator> validators = [];

  ValidatorBuilder._(this.fieldName);

  static ValidatorBuilder field(String fieldName) {
    _instance = ValidatorBuilder._(fieldName);
    return _instance;
  }

  ValidatorBuilder requiredField() {
    validators.add(RequiredFieldValidator(fieldName));
    return this;
  }

  ValidatorBuilder email() {
    validators.add(EmailValidator(fieldName));
    return this;
  }

  ValidatorBuilder min(int length) {
    validators.add(MinLengthValidator(field: fieldName, minLength: length));
    return this;
  }

  List<FieldValidator> build() => validators;
}
