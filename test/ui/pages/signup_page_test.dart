import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fordev_tdd/ui/helpers/errors/ui_error.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get/get.dart';

import 'package:fordev_tdd/main/apps/app_routes.dart';
import 'package:fordev_tdd/ui/helpers/i18n/i18n.dart';
import 'package:fordev_tdd/ui/pages/pages.dart';

import '../mocks/mocks.dart';

void main() {
  late SignUpPresenterSpy presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = SignUpPresenterSpy();
    final signupPage = GetMaterialApp(
      initialRoute: AppRoutes.signup,
      getPages: [
        GetPage(name: AppRoutes.signup, page: () => SignUpPage(presenter)),
      ],
    );
    await tester.pumpWidget(signupPage);
  }

  tearDown(() {
    presenter.dispose();
  });

  testWidgets('Should load SigUpPage with correct initial state',
      (WidgetTester tester) async {
    // Arrange
    await loadPage(tester);

    // When a TextFormField has only one text child, means it has no errors,
    // since one of the children is always the labelText widget
    final nameText = find.descendant(
      of: find.bySemanticsLabel(R.strings.name),
      matching: find.byType(Text),
    );
    expect(nameText, findsOneWidget);

    final emailText = find.descendant(
      of: find.bySemanticsLabel(R.strings.email),
      matching: find.byType(Text),
    );
    expect(emailText, findsOneWidget);

    final passwordText = find.descendant(
      of: find.bySemanticsLabel(R.strings.password),
      matching: find.byType(Text),
    );
    expect(passwordText, findsOneWidget);

    final passwordConfirmationText = find.descendant(
      of: find.bySemanticsLabel(R.strings.passwordConfirmation),
      matching: find.byType(Text),
    );
    expect(passwordConfirmationText, findsOneWidget);

    // When app starts login button should be disabled
    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);

    // No loading on start
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should call validate when any field changed',
      (WidgetTester tester) async {
    // Arrange
    await loadPage(tester);
    // Act & Assert
    final name = faker.person.name();
    await tester.enterText(find.bySemanticsLabel(R.strings.name), name);
    verify(() => presenter.validateName(name));

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel(R.strings.email), email);
    verify(() => presenter.validateEmail(email));

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel(R.strings.password), password);
    verify(() => presenter.validatePassword(password));

    await tester.enterText(
        find.bySemanticsLabel(R.strings.passwordConfirmation), password);
    verify(() => presenter.validatePasswordConfirmation(password));
  });

  testWidgets('Should present name error', (WidgetTester tester) async {
    await loadPage(tester);

    // Invalid e-mail
    presenter.emitNameError(UIError.invalidField);
    await tester.pump();
    expect(find.text(UIError.invalidField.description), findsOneWidget);

    // Empty e-mail
    presenter.emitNameError(UIError.requiredField);
    await tester.pump();
    expect(find.text(UIError.requiredField.description), findsOneWidget);

    // No e-mail error
    presenter.emitNameError(null);
    await tester.pump();
    // When a TextFormField has only one text child, means it has no errors,
    // since one of the children is always the labelText widget
    final emailText = find.descendant(
      of: find.bySemanticsLabel(R.strings.name),
      matching: find.byType(Text),
    );
    expect(emailText, findsOneWidget);
  });
  testWidgets('Should present email error', (WidgetTester tester) async {
    await loadPage(tester);

    // Invalid e-mail
    presenter.emitEmailError(UIError.invalidField);
    await tester.pump();
    expect(find.text(UIError.invalidField.description), findsOneWidget);

    // Empty e-mail
    presenter.emitEmailError(UIError.requiredField);
    await tester.pump();
    expect(find.text(UIError.requiredField.description), findsOneWidget);

    // No e-mail error
    presenter.emitEmailError(null);
    await tester.pump();
    // When a TextFormField has only one text child, means it has no errors,
    // since one of the children is always the labelText widget
    final emailText = find.descendant(
      of: find.bySemanticsLabel(R.strings.email),
      matching: find.byType(Text),
    );
    expect(emailText, findsOneWidget);
  });

  testWidgets('Should present password error', (WidgetTester tester) async {
    await loadPage(tester);

    // Invalid e-mail
    presenter.emitPasswordError(UIError.invalidField);
    await tester.pump();
    expect(find.text(UIError.invalidField.description), findsOneWidget);

    // Empty e-mail
    presenter.emitPasswordError(UIError.requiredField);
    await tester.pump();
    expect(find.text(UIError.requiredField.description), findsOneWidget);

    // No e-mail error
    presenter.emitPasswordError(null);
    await tester.pump();
    // When a TextFormField has only one text child, means it has no errors,
    // since one of the children is always the labelText widget
    final emailText = find.descendant(
      of: find.bySemanticsLabel(R.strings.password),
      matching: find.byType(Text),
    );
    expect(emailText, findsOneWidget);
  });

  testWidgets('Should present password confirmation error',
      (WidgetTester tester) async {
    await loadPage(tester);

    // Invalid e-mail
    presenter.emitPasswordConfirmationError(UIError.invalidField);
    await tester.pump();
    expect(find.text(UIError.invalidField.description), findsOneWidget);

    // Empty e-mail
    presenter.emitPasswordConfirmationError(UIError.requiredField);
    await tester.pump();
    expect(find.text(UIError.requiredField.description), findsOneWidget);

    // No e-mail error
    presenter.emitPasswordConfirmationError(null);
    await tester.pump();
    // When a TextFormField has only one text child, means it has no errors,
    // since one of the children is always the labelText widget
    final emailText = find.descendant(
      of: find.bySemanticsLabel(R.strings.passwordConfirmation),
      matching: find.byType(Text),
    );
    expect(emailText, findsOneWidget);
  });

  testWidgets('Should enable button if form is valid',
      (WidgetTester tester) async {
    ElevatedButton button;

    await loadPage(tester);

    presenter.emitFormValid();
    await tester.pump();

    button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNotNull);

    presenter.emitFormError();
    await tester.pump();

    button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNull);
  });

  testWidgets('Should call signUp() on form submit',
      (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitFormValid();
    await tester.pump();

    final button = find.byType(ElevatedButton);
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pump();

    verify(() => presenter.signUp()).called(1);
  });

  testWidgets('Should present/hide loading', (WidgetTester tester) async {
    await loadPage(tester);

    // Show loading
    presenter.emitLoadind(true);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    // Hide loading
    presenter.emitLoadind(false);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
