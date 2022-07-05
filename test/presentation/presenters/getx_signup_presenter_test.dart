import 'package:faker/faker.dart';
import 'package:fordev_tdd/domain/entities/entities.dart';
import 'package:fordev_tdd/domain/helpers/domain_error.dart';
import 'package:fordev_tdd/main/apps/app_routes.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/domain/usecases/add_account.dart';
import 'package:fordev_tdd/presentation/protocols/validator.dart';
import 'package:fordev_tdd/ui/helpers/errors/errors.dart';
import 'package:fordev_tdd/presentation/presenters/presenters.dart';

import '../../domain/mocks/mocks.dart';
import '../../ui/mocks/mocks.dart';

void main() {
  late GetxSignUpPresenter sut;
  late ValidationSpy validator;
  late AddAccountSpy addAccount;
  late SaveCurrentAccountSpy saveCurrentAccount;
  late String name;
  late String email;
  late String password;
  late String passwordConfirmation;
  late String token;

  setUp(() {
    validator = ValidationSpy();
    addAccount = AddAccountSpy();
    saveCurrentAccount = SaveCurrentAccountSpy();
    sut = GetxSignUpPresenter(
      validator: validator,
      addAccount: addAccount,
      saveCurrentAccount: saveCurrentAccount,
    );
    token = faker.guid.guid();
    name = faker.person.name();
    email = faker.internet.email();
    password = faker.internet.password();
    passwordConfirmation = password;
  });

  test('Should call validation with correct email', () {
    // Arrange
    final input = {
      GetxSignUpPresenter.nameFieldName: null,
      GetxSignUpPresenter.emailFieldName: email,
      GetxSignUpPresenter.passwordFieldName: null,
      GetxSignUpPresenter.passwordConfirmationFieldName: null,
    };
    validator.mockValidate(value: null);
    // Act
    sut.validateEmail(email);
    // Assert
    verify(() => validator.validate(
          field: GetxSignUpPresenter.emailFieldName,
          input: input,
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
    final input = {
      GetxSignUpPresenter.nameFieldName: name,
      GetxSignUpPresenter.emailFieldName: null,
      GetxSignUpPresenter.passwordFieldName: null,
      GetxSignUpPresenter.passwordConfirmationFieldName: null,
    };
    validator.mockValidate(value: null);
    // Act
    sut.validateName(name);
    // Assert
    verify(() => validator.validate(
          field: GetxSignUpPresenter.nameFieldName,
          input: input,
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
    final input = {
      GetxSignUpPresenter.nameFieldName: null,
      GetxSignUpPresenter.emailFieldName: null,
      GetxSignUpPresenter.passwordFieldName: password,
      GetxSignUpPresenter.passwordConfirmationFieldName: null,
    };
    validator.mockValidate(value: null);
    // Act
    sut.validatePassword(password);
    // Assert
    verify(() => validator.validate(
          field: GetxSignUpPresenter.passwordFieldName,
          input: input,
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
    final input = {
      GetxSignUpPresenter.nameFieldName: null,
      GetxSignUpPresenter.emailFieldName: null,
      GetxSignUpPresenter.passwordFieldName: null,
      GetxSignUpPresenter.passwordConfirmationFieldName: passwordConfirmation,
    };
    validator.mockValidate(value: null);
    // Act
    sut.validatePasswordConfirmation(passwordConfirmation);
    // Assert
    verify(() => validator.validate(
          field: GetxSignUpPresenter.passwordConfirmationFieldName,
          input: input,
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
    saveCurrentAccount.mockSave();

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

  test('Should call SaveCurrentAccount with correct parameter', () async {
    // Arrange
    addAccount.mockAdd(token);
    saveCurrentAccount.mockSave();

    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);
    // Act
    await sut.signUp();
    // Assert
    verify(() => saveCurrentAccount.save(AccountEntity(token: token)))
        .called(1);
  });

  test('Should emit UnexpectedError if SaveCurrentAccount fails', () async {
    // Arrange
    addAccount.mockAdd(token);
    saveCurrentAccount.mockError();

    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);
    // Assert Later
    expectLater(sut.mainErrorStream, emitsInOrder([null, UIError.unexpected]));
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    // Act
    await sut.signUp();
  });

  test('Should emit correct events on AddAccount success', () async {
    // Arrange
    addAccount.mockAdd(token);
    saveCurrentAccount.mockSave();

    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);
    // Assert Later
    expectLater(sut.mainErrorStream, emits(null));
    expectLater(sut.isLoadingStream, emits(true));
    // Act
    await sut.signUp();
  });

  test('Should emit correct events on EmailInUseError', () async {
    // Arrange
    addAccount.mockAddError(DomainError.emailInUse);

    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);
    // Assert Later
    expectLater(sut.mainErrorStream, emitsInOrder([null, UIError.emailInUse]));
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    // Act
    await sut.signUp();
  });

  test('Should emit correct events on UnexpectedError', () async {
    // Arrange
    addAccount.mockAddError(DomainError.unexpected);

    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);
    // Assert Later
    expectLater(sut.mainErrorStream, emitsInOrder([null, UIError.unexpected]));
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    // Act
    await sut.signUp();
  });

  test('Should change page on success', () async {
    // Arrange
    addAccount.mockAdd(token);
    saveCurrentAccount.mockSave();

    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);
    // Assert Later
    sut.navigateToStream
        .listen(expectAsync1((page) => expect(page, AppRoutes.surveys)));
    // Act
    await sut.signUp();
  });

  test('Should login page on link success', () async {
    // Assert Later
    sut.navigateToStream
        .listen(expectAsync1((page) => expect(page, AppRoutes.login)));
    sut.goToLogin();
  });
}
