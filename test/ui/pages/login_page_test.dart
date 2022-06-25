import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fordev_tdd/ui/pages/login/login_page.dart';
import 'package:fordev_tdd/ui/pages/login/login_presenter.dart';
import 'package:fordev_tdd/utils/i18n/i18n.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/login_presenter_spy.dart';

void main() {
  late LoginPresenterSpy presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = LoginPresenterSpy();
    final loginPage = MaterialApp(home: LoginPage(presenter));
    await tester.pumpWidget(loginPage);
  }

  tearDown(() {
    presenter.dispose();
  });

  testWidgets('Should load with correct initial state',
      (WidgetTester tester) async {
    // Arrange
    await loadPage(tester);

    // When a TextFormField has only one text child, means it has no errors,
    // since one of the children is always the labelText widget
    final emailText = find.descendant(
      of: find.bySemanticsLabel(R.strings.email),
      matching: find.byType(Text),
    );
    expect(emailText, findsOneWidget);

    // When a TextFormField has only one text child, means it has no errors,
    // since one of the children is always the labelText widget
    final passwordText = find.descendant(
      of: find.bySemanticsLabel(R.strings.password),
      matching: find.byType(Text),
    );
    expect(passwordText, findsOneWidget);

    // When app starts login button should be disabled
    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
  });

  testWidgets('Should call validate with correct values',
      (WidgetTester tester) async {
    await loadPage(tester);

    // Should call validateEmail by typing in email field
    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel(R.strings.email), email);
    verify(() => presenter.validateEmail(email));

    // Should call validatePassword by typing in email field
    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel(R.strings.password), password);

    verify(() => presenter.validatePassword(password));
  });

  testWidgets('Should present error if email is invalid',
      (WidgetTester tester) async {
    await loadPage(tester);

    const error = 'some_error';

    presenter.emitEmailError(error);
    await tester.pump();

    expect(find.text(error), findsOneWidget);
  });

  testWidgets('Should present no error if email is valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitEmailError('');
    await tester.pump();

    // When a TextFormField has only one text child, means it has no errors,
    // since one of the children is always the labelText widget
    final emailText = find.descendant(
      of: find.bySemanticsLabel(R.strings.email),
      matching: find.byType(Text),
    );
    expect(emailText, findsOneWidget);
  });

  testWidgets('Should present error if password is invalid',
      (WidgetTester tester) async {
    await loadPage(tester);

    const error = 'some_error';

    presenter.emitPasswordError(error);
    await tester.pump();

    expect(find.text(error), findsOneWidget);
  });

  testWidgets('Should present no error if password is valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitPasswordError('');
    await tester.pump();

    // When a TextFormField has only one text child, means it has no errors,
    // since one of the children is always the labelText widget
    final passwordText = find.descendant(
      of: find.bySemanticsLabel(R.strings.password),
      matching: find.byType(Text),
    );
    expect(passwordText, findsOneWidget);
  });

  testWidgets('Should enable button if form is valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitFormValid();
    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNotNull);
  });

  testWidgets('Should disable button if form is invalid',
      (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitFormError();
    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNull);
  });

  testWidgets('Should call authentication on form submit',
      (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitFormValid();
    await tester.pump();
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    verify(() => presenter.auth()).called(1);
  });

  testWidgets('Should present loading', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitLoadind(true);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
