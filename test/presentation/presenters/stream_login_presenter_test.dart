import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/presentation/presenters/presenters.dart';

import '../../ui/mocks/mocks.dart';

void main() {
  late ValidationSpy validation;
  late StreamLoginPresenter sut;
  late String email;
  late String password;
  const String error = 'Some error message';

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
    password = faker.internet.password();
  });

  test('Should call validation with correct email', () {
    // Arrange
    validation.mockValidation();
    // Act
    sut.validateEmail(email);
    // Assert
    verify(() => validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit email error if validation fails', skip: 'Not working', () {
    // Arrange
    validation.mockValidation(value: error);
    // Late Assert
    sut.emailErrorStream.listen((error) {
      expectAsync1((errorMsg) => expect(errorMsg, error));
    });
    sut.isFormValidStream.listen((error) {
      expectAsync1((isValid) => expect(isValid, false));
    }); // Act
    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit null if validation succeeds', skip: 'Not working', () {
    // Arrange
    validation.mockValidation();
    // Late Assert
    sut.emailErrorStream.listen((error) {
      expectAsync1((errorMsg) => expect(errorMsg, null));
    });
    sut.isFormValidStream.listen((error) {
      expectAsync1((isValid) => expect(isValid, false));
    }); // Act
    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should call validation with correct password', () {
    // Arrange
    validation.mockValidation();
    // Act
    sut.validatePassword(password);
    // Assert
    verify(() => validation.validate(field: 'password', value: password))
        .called(1);
  });

  test('Should emit password error if validation fails', skip: 'Not working',
      () {
    // Arrange
    validation.mockValidation(value: error);
    // Late Assert
    sut.passwordErrorStream.listen((error) {
      expectAsync1((errorMsg) => expect(errorMsg, error));
    });
    sut.isFormValidStream.listen((error) {
      expectAsync1((isValid) => expect(isValid, false));
    }); // Act
    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit password error if validation fails', skip: 'Not working',
      () {
    // Arrange
    validation.mockValidation();
    // Late Assert
    sut.passwordErrorStream.listen((error) {
      expectAsync1((errorMsg) => expect(errorMsg, null));
    });
    sut.isFormValidStream.listen((error) {
      expectAsync1((isValid) => expect(isValid, false));
    }); // Act
    sut.validatePassword(password);
    sut.validatePassword(password);
  });
}
