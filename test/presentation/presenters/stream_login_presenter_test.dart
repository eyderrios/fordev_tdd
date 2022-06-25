import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/presentation/presenters/stream_login_presenter.dart';

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
    validation.mockValidate(null);

    sut.validateEmail(email);

    verify(() => validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit email error if validation fails', () {
    // Arrange
    validation.mockValidate(error);
    // Late Assert
    expectLater(sut.emailErrorStream, emits(error));
    // Act
    sut.validateEmail(email);
  });
}
