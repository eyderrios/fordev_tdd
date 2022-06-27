import 'package:faker/faker.dart';
import 'package:fordev_tdd/domain/usecases/authentication.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/presentation/presenters/presenters.dart';

import '../../domain/mocks/mocks.dart';
import '../../ui/mocks/mocks.dart';

void main() {
  const String error = 'Some error message';
  late String email;
  late String password;

  late AuthenticationParams params;
  late ValidationSpy validator;
  late AuthenticationSpy auth;
  late StreamLoginPresenter sut;

  setUp(() {
    email = faker.internet.email();
    password = faker.internet.password();
    params = AuthenticationParams(email: email, password: password);
    auth = AuthenticationSpy();
    validator = ValidationSpy();
    sut = StreamLoginPresenter(validator: validator, authentication: auth);
  });

  test('Should call validation with correct email', () {
    // Arrange
    validator.mockValidate(value: null);
    // Act
    sut.validateEmail(email);
    // Assert
    verify(() => validator.validate(
          field: StreamLoginPresenter.emailFieldName,
          value: email,
        )).called(1);
  });

  test('Should emit email error if validation fails', () {
    validator.mockValidate(value: error);

    sut.emailErrorStream
        .listen(expectAsync1((errorMsg) => expect(errorMsg, error)));
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
    validator.mockValidate(value: password);
    // Act
    sut.validatePassword(password);
    // Assert
    verify(() => validator.validate(
          field: StreamLoginPresenter.passwordFieldName,
          value: password,
        )).called(1);
  });

  test('Should emit password error if validation fails', () {
    // Arrange
    validator.mockValidate(value: error);
    // Late Assert
    sut.passwordErrorStream
        .listen(expectAsync1((errorMsg) => expect(errorMsg, error)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));
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

  test('Should emit error if validations fails', () {
    // Arrange
    validator.mockValidate(
      field: StreamLoginPresenter.emailFieldName,
      value: error,
    );
    validator.mockValidate(
      field: StreamLoginPresenter.passwordFieldName,
      value: null,
    );
    // Late Assert
    sut.emailErrorStream
        .listen(expectAsync1((errorMsg) => expect(errorMsg, error)));
    sut.passwordErrorStream
        .listen(expectAsync1((errorMsg) => expect(errorMsg, null)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));
    // Act
    sut.validateEmail(email);
    sut.validatePassword(password);
  });

  test('Should emit null if validation succeed', () async {
    // Arrange
    validator.mockValidate(
      field: StreamLoginPresenter.emailFieldName,
      value: null,
    );
    validator.mockValidate(
      field: StreamLoginPresenter.passwordFieldName,
      value: null,
    );
    // Late Assert
    sut.emailErrorStream
        .listen(expectAsync1((errorMsg) => expect(errorMsg, null)));
    sut.passwordErrorStream
        .listen(expectAsync1((errorMsg) => expect(errorMsg, null)));
    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));
    // Act
    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);
  });

  test('Should call Authentication if correct parameters', () async {
    // Arrange
    auth.mockAuth(params);

    sut.validateEmail(email);
    sut.validatePassword(password);
    // Act
    await sut.auth();
    // Assert
    verify(() => auth.auth(params)).called(1);
  });
}
