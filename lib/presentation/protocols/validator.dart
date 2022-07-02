enum ValidatorError {
  requiredField,
  invalidField,
}

abstract class Validator {
  ValidatorError? validate({required String field, required String value});
}
