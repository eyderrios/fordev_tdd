import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/presentation/presenters/presenters.dart';

import '../../ui/mocks/mocks.dart';

void main() {
  late ValidationSpy validator;
  late StreamLoginPresenter sut;
  late String email;
  late String password;
  const String error = 'Some error message';

  setUp(() {
    validator = ValidationSpy();
    sut = StreamLoginPresenter(validator: validator);
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

  test('Should ', () {
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
    sut.validateEmail(password);
    sut.validatePassword(password);
  });
}
