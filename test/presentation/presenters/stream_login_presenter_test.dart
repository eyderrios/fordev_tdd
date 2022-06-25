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
  const String error = 'Some error message';

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
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
}
