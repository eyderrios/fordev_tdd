enum ValidatorError {
  requiredField,
  invalidField,
}

typedef ValidatorFieldInput = Map<String, dynamic>;

abstract class Validator {
  ValidatorError? validate(
      {required String field, required ValidatorFieldInput input});
}
