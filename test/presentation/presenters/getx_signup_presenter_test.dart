import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/domain/usecases/add_account.dart';
import 'package:fordev_tdd/presentation/protocols/validator.dart';
import 'package:fordev_tdd/ui/helpers/errors/errors.dart';
import 'package:fordev_tdd/presentation/presenters/presenters.dart';

import '../../ui/mocks/mocks.dart';

void main() {
  late GetxSignUpPresenter sut;
  late ValidationSpy validator;
  late AddAccountSpy addAccount;
  late String name;
  late String email;
  late String password;
  late String passwordConfirmation;
  late String token;

  setUp(() {
    validator = ValidationSpy();
    addAccount = AddAccountSpy();
    sut = GetxSignUpPresenter(
      validator: validator,
      addAccount: addAccount,
    );
    token = faker.guid.guid();
    name = faker.person.name();
    email = faker.internet.email();
    password = faker.internet.password();
    passwordConfirmation = password;
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

  test('Should call validation with correct password confirmation', () {
    // Arrange
    validator.mockValidate(value: null);
    // Act
    sut.validatePasswordConfirmation(passwordConfirmation);
    // Assert
    verify(() => validator.validate(
          field: GetxSignUpPresenter.passwordConfirmationFieldName,
          value: passwordConfirmation,
        )).called(1);
  });

  test('Should emit invalidFieldError if password confirmation is invalid', () {
    validator.mockValidate(value: ValidatorError.invalidField);

    sut.passwordConfirmationErrorStream.listen(
        expectAsync1((errorMsg) => expect(errorMsg, UIError.invalidField)));
    sut.isFormValidStream.listen((isValid) => expect(isValid, false));

    sut.validatePasswordConfirmation(passwordConfirmation);
    sut.validatePasswordConfirmation(passwordConfirmation);
  });

  test('Should emit requiredFieldError if password confirmation is empty', () {
    validator.mockValidate(value: ValidatorError.requiredField);

    sut.passwordConfirmationErrorStream.listen(
        expectAsync1((errorMsg) => expect(errorMsg, UIError.requiredField)));
    sut.isFormValidStream.listen((isValid) => expect(isValid, false));

    sut.validatePasswordConfirmation(passwordConfirmation);
    sut.validatePasswordConfirmation(passwordConfirmation);
  });

  test('Should emit null if validation succeeds', () {
    validator.mockValidate(value: null);

    sut.passwordConfirmationErrorStream.listen(expectAsync1((errorMsg) {
      expect(errorMsg, null);
    }));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePasswordConfirmation(passwordConfirmation);
    sut.validatePasswordConfirmation(passwordConfirmation);
  });

  test('Should enable form buttom if all field are valid', () async {
    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));

    sut.validateName(name);
    await Future.delayed(Duration.zero);
    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);
    await Future.delayed(Duration.zero);
    sut.validatePasswordConfirmation(passwordConfirmation);
    await Future.delayed(Duration.zero);
  });

  test('Should call AddAccount.sigup() with correct parameters', () async {
    // Arrange
    addAccount.mockAdd(token);
    // saveCurrentAccount.mockSave();

    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);
    // Act
    await sut.signUp();
    // Assert
    final params = AddAccountParams(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );

    verify(() => addAccount.add(params)).called(1);
  });
}
