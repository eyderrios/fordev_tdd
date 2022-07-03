import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:fordev_tdd/main/apps/app_routes.dart';
import 'package:fordev_tdd/ui/helpers/i18n/i18n.dart';
import 'package:fordev_tdd/ui/pages/pages.dart';

import '../mocks/login_presenter_spy.dart';

void main() {
  late SignupPresenterSpy presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = SignupPresenterSpy();
    final signupPage = GetMaterialApp(
      initialRoute: AppRoutes.signup,
      getPages: [
        GetPage(name: AppRoutes.signup, page: () => const SignUpPage()),
      ],
    );
    await tester.pumpWidget(signupPage);
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
}
