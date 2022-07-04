import 'package:faker/faker.dart';
import 'package:fordev_tdd/domain/entities/account_entity.dart';
import 'package:fordev_tdd/main/apps/app_routes.dart';
import 'package:fordev_tdd/presentation/protocols/validator.dart';
import 'package:fordev_tdd/ui/helpers/errors/errors.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/domain/helpers/domain_error.dart';
import 'package:fordev_tdd/domain/usecases/authentication.dart';
import 'package:fordev_tdd/presentation/presenters/presenters.dart';

import '../../domain/mocks/mocks.dart';
import '../../domain/mocks/save_current_account_spy.dart';
import '../../ui/mocks/mocks.dart';

void main() {
  late String email;
  late String password;
  late String token;

  late AuthenticationParams params;
  late AuthenticationSpy auth;
  late ValidationSpy validator;
  late SaveCurrentAccountSpy saveCurrentAccount;
  late GetxLoginPresenter sut;

  setUp(() {
    email = faker.internet.email();
    password = faker.internet.password();
    token = faker.guid.guid();
    params = AuthenticationParams(email: email, password: password);
    auth = AuthenticationSpy();
    validator = ValidationSpy();
    saveCurrentAccount = SaveCurrentAccountSpy();
    sut = GetxLoginPresenter(
      validator: validator,
      authentication: auth,
      saveCurrentAccount: saveCurrentAccount,
    );
  });

  test('Should call validation with correct email', () {
    // Arrange
    validator.mockValidate(value: null);
    // Act
    sut.validateEmail(email);
    // Assert
    verify(() => validator.validate(
          field: GetxLoginPresenter.emailFieldName,
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

  test('Should call validation with correct password', () {
    // Arrange
    validator.mockValidate(value: null);
    // Act
    sut.validatePassword(password);
    // Assert
    verify(() => validator.validate(
          field: GetxLoginPresenter.passwordFieldName,
          value: password,
        )).called(1);
  });

  test('Should emit requiredFieldError if password is empty', () {
    // Arrange
    validator.mockValidate(value: ValidatorError.requiredField);
    // Late assert
    sut.passwordErrorStream.listen(
        expectAsync1((errorMsg) => expect(errorMsg, UIError.requiredField)));
    sut.isFormValidStream.listen((isValid) => expect(isValid, false));
    // Act
    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit null if validation succeeds', () {
    // Arrange
    validator.mockValidate(value: null);
    // Late Assert
    sut.passwordErrorStream
        .listen(expectAsync1((errorMsg) => expect(errorMsg, null)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));
    // Act
    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should disable form buttom if any field is invalid', () {
    // Arrange
    validator.mockValidate(
      field: GetxLoginPresenter.emailFieldName,
      value: ValidatorError.invalidField,
    );
    // Late Assert
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));
    // Act
    sut.validateEmail(email);
    sut.validatePassword(password);
  });

  test('Should enable form buttom if all field are valid', () async {
    // Arrange
    // validator.mockValidate(
    //   field: GetxLoginPresenter.emailFieldName,
    //   value: null,
    // );
    // validator.mockValidate(
    //   field: GetxLoginPresenter.passwordFieldName,
    //   value: null,
    // );
    // Late Assert
    // sut.emailErrorStream
    //     .listen(expectAsync1((errorMsg) => expect(errorMsg, null)));
    // sut.passwordErrorStream
    //     .listen(expectAsync1((errorMsg) => expect(errorMsg, null)));
    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));
    // Act
    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);
  });

  test('Should call Authentication.auth() with correct parameters', () async {
    // Arrange
    auth.mockAuth(params);
    saveCurrentAccount.mockSave();

    sut.validateEmail(email);
    sut.validatePassword(password);
    // Act
    await sut.auth();
    // Assert
    verify(() => auth.auth(params)).called(1);
  });

  test('Should call SaveCurrentAccount with correct parameter', () async {
    // Arrange
    auth.mockAuth(params, token: token);
    saveCurrentAccount.mockSave();

    sut.validateEmail(email);
    sut.validatePassword(password);
    // Act
    await sut.auth();
    // Assert
    verify(() => saveCurrentAccount.save(AccountEntity(token: token)))
        .called(1);
  });

  test('Should emit UnexpectedError if SaveCurrentAccount fails', () async {
    // Arrange
    const domainError = DomainError.unexpected;
    auth.mockAuthError(params, domainError);
    saveCurrentAccount.mockError();

    sut.validateEmail(email);
    sut.validatePassword(password);
    // Assert Later
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.mainErrorStream.listen(expectAsync1((errorMsg) => expect(
          errorMsg,
          UIError.unexpected,
        )));
    // Act
    await sut.auth();
  });

  test('Should emit correct events on authentication success', () async {
    // Arrange
    auth.mockAuth(params);
    saveCurrentAccount.mockSave();

    sut.validateEmail(email);
    sut.validatePassword(password);
    // Assert Later
    expectLater(sut.isLoadingStream, emits(true));
    // Act
    await sut.auth();
  });

  test('Should change page on success', () async {
    // Arrange
    auth.mockAuth(params);
    saveCurrentAccount.mockSave();

    sut.validateEmail(email);
    sut.validatePassword(password);
    // Assert Later
    sut.navigateToStream
        .listen(expectAsync1((page) => expect(page, AppRoutes.surveys)));
    // Act
    await sut.auth();
  });

  test('Should emit correct events on InvalidCredentialsError', () async {
    // Arrange
    const domainError = DomainError.invalidCredentials;
    auth.mockAuthError(params, domainError);

    sut.validateEmail(email);
    sut.validatePassword(password);
    // Assert Later
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.mainErrorStream.listen(expectAsync1((errorMsg) => expect(
          errorMsg,
          UIError.invalidCredentials,
        )));
    // Act
    await sut.auth();
  });

  test('Should emit correct events on UnexpectedError', () async {
    // Arrange
    const domainError = DomainError.unexpected;
    auth.mockAuthError(params, domainError);

    sut.validateEmail(email);
    sut.validatePassword(password);
    // Assert Later
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.mainErrorStream.listen(expectAsync1((errorMsg) => expect(
          errorMsg,
          UIError.unexpected,
        )));
    // Act
    await sut.auth();
  });
}
