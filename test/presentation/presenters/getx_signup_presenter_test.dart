import 'package:faker/faker.dart';
import 'package:fordev_tdd/presentation/protocols/validator.dart';
import 'package:fordev_tdd/ui/helpers/errors/errors.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/presentation/presenters/presenters.dart';

import '../../ui/mocks/mocks.dart';

void main() {
  late GetxSignUpPresenter sut;
  late ValidationSpy validator;
  late String name;
  late String email;
  late String password;

  setUp(() {
    validator = ValidationSpy();
    sut = GetxSignUpPresenter(
      validator: validator,
    );
    name = faker.person.name();
    email = faker.internet.email();
    password = faker.internet.password();
  });

  test('Should call validation with correct email', () {
    // Arrange
    validator.mockValidate(value: null);
    // Act
    sut.validateEmail(email);
    // Assert
    verify(() => validator.validate(
          field: GetxSignUpPresenter.emailFieldName,
          value: email,
        )).called(1);
  });

  test('Should emit invalidFieldError if email is invalid', () {
    validator.mockValidate(value: ValidatorError.invalidField);

    sut.emailErrorStream.listen(
        expectAsync1((errorMsg) => expect(errorMsg, UIError.invalidField)));
    sut.isFormValidStream.listen((isValid) => expect(isValid, false));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit requiredFieldError if email is empty', () {
    validator.mockValidate(value: ValidatorError.requiredField);

    sut.emailErrorStream.listen(
        expectAsync1((errorMsg) => expect(errorMsg, UIError.requiredField)));
    sut.isFormValidStream.listen((isValid) => expect(isValid, false));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit null if validation succeeds', () {
    // Arrange
    validator.mockValidate(value: null);
    // Late Assert
    sut.emailErrorStream.listen(expectAsync1((errorMsg) {
      expect(errorMsg, null);
    }));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));
    // Act
    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should call validation with correct name', () {
    // Arrange
    validator.mockValidate(value: null);
    // Act
    sut.validateName(name);
    // Assert
    verify(() => validator.validate(
          field: GetxSignUpPresenter.nameFieldName,
          value: name,
        )).called(1);
  });

  test('Should emit invalidFieldError if name is invalid', () {
    validator.mockValidate(value: ValidatorError.invalidField);

    sut.nameErrorStream.listen(
        expectAsync1((errorMsg) => expect(errorMsg, UIError.invalidField)));
    sut.isFormValidStream.listen((isValid) => expect(isValid, false));

    sut.validateName(name);
    sut.validateName(name);
  });

  test('Should emit requiredFieldError if name is empty', () {
    validator.mockValidate(value: ValidatorError.requiredField);

    sut.nameErrorStream.listen(
        expectAsync1((errorMsg) => expect(errorMsg, UIError.requiredField)));
    sut.isFormValidStream.listen((isValid) => expect(isValid, false));

    sut.validateName(name);
    sut.validateName(name);
  });

  test('Should emit null if validation succeeds', () {
    // Arrange
    validator.mockValidate(value: null);
    // Late Assert
    sut.nameErrorStream.listen(expectAsync1((errorMsg) {
      expect(errorMsg, null);
    }));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));
    // Act
    sut.validateName(name);
    sut.validateName(name);
  });

  test('Should call validation with correct password', () {
    // Arrange
    validator.mockValidate(value: null);
    // Act
    sut.validatePassword(password);
    // Assert
    verify(() => validator.validate(
          field: GetxSignUpPresenter.passwordFieldName,
          value: password,
        )).called(1);
  });

  test('Should emit invalidFieldError if password is invalid', () {
    validator.mockValidate(value: ValidatorError.invalidField);

    sut.passwordErrorStream.listen(
        expectAsync1((errorMsg) => expect(errorMsg, UIError.invalidField)));
    sut.isFormValidStream.listen((isValid) => expect(isValid, false));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit requiredFieldError if password is empty', () {
    validator.mockValidate(value: ValidatorError.requiredField);

    sut.passwordErrorStream.listen(
        expectAsync1((errorMsg) => expect(errorMsg, UIError.requiredField)));
    sut.isFormValidStream.listen((isValid) => expect(isValid, false));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit null if validation succeeds', () {
    // Arrange
    validator.mockValidate(value: null);
    // Late Assert
    sut.passwordErrorStream.listen(expectAsync1((errorMsg) {
      expect(errorMsg, null);
    }));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));
    // Act
    sut.validatePassword(password);
    sut.validatePassword(password);
  });
}
