import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/main/apps/app_routes.dart';
import 'package:fordev_tdd/ui/helpers/errors/errors.dart';
import 'package:fordev_tdd/ui/helpers/i18n/i18n.dart';
import 'package:fordev_tdd/ui/pages/login/login_page.dart';

import '../mocks/login_presenter_spy.dart';

void main() {
  const fakeRoute = '/fake_route';
  const fakePageTitle = 'Fake Page Title';
  late LoginPresenterSpy presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = LoginPresenterSpy();
    final loginPage = GetMaterialApp(
      initialRoute: AppRoutes.login,
      getPages: [
        GetPage(name: AppRoutes.login, page: () => LoginPage(presenter)),
        GetPage(
          name: fakeRoute,
          page: () => const Scaffold(body: Text(fakePageTitle)),
        ),
      ],
    );
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

    // No loading on start
    expect(find.byType(CircularProgressIndicator), findsNothing);
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

    presenter.emitEmailError(UIError.invalidField);
    await tester.pump();

    expect(find.text(UIError.invalidField.description), findsOneWidget);
  });

  testWidgets('Should present error if email is empty',
      (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitEmailError(UIError.requiredField);
    await tester.pump();

    expect(find.text(UIError.requiredField.description), findsOneWidget);
  });

  testWidgets('Should present no error if email is valid',
      (WidgetTester tester) async {
    await loadPage(tester);

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

  testWidgets('Should present error if password is empty',
      (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitPasswordError(UIError.requiredField);
    await tester.pump();

    expect(find.text(UIError.requiredField.description), findsOneWidget);
  });

  testWidgets('Should present no error if password is valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitPasswordError(null);
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
    final button = find.byType(ElevatedButton);
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pump();

    verify(() => presenter.auth()).called(1);
  });

  testWidgets('Should hide loading', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitLoadind(true);
    await tester.pump();
    presenter.emitLoadind(false);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should present error message if authentication fails',
      (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitMainError(UIError.invalidCredentials);
    await tester.pump();

    expect(find.text(UIError.invalidCredentials.description), findsOneWidget);
  });

  testWidgets('Should present error message if authentication throws',
      (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitMainError(UIError.unexpected);
    await tester.pump();

    expect(find.text(UIError.unexpected.description), findsOneWidget);
  });

  testWidgets('Should change page', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitNavigateTo(fakeRoute);
    await tester.pumpAndSettle();

    expect(Get.currentRoute, fakeRoute);
    expect(find.text(fakePageTitle), findsOneWidget);
  });
}
