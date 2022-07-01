import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/ui/pages/splash/splash_page.dart';

import '../mocks/mocks.dart';

void main() {
  const route = '/some_route';
  const pageTitle = 'Fake Page Title';
  late SplashPresenterSpy presenter;

  setUp(() {
    presenter = SplashPresenterSpy();
  });

  //tearDown(() {});

  Future<void> loadPage(WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => SplashPage(presenter: presenter)),
          GetPage(
              name: route, page: () => const Scaffold(body: Text(pageTitle))),
        ],
      ),
    );
  }

  testWidgets('Should present spinner on page load',
      (WidgetTester tester) async {
    // Arrange
    presenter.mockMethods();
    // Act
    await loadPage(tester);
    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should call loadCurrentAccount on page load',
      (WidgetTester tester) async {
    // Arrange
    presenter.mockMethods();
    // Act
    await loadPage(tester);
    // Assert
    verify(() => presenter.loadCurrentAccount()).called(1);
  });

  testWidgets('Should load page after spinner', (WidgetTester tester) async {
    // Arrange
    presenter.mockMethods();
    await loadPage(tester);
    // Act
    presenter.navigateToController.add(route);
    await tester.pumpAndSettle();
    // Assert
    expect(Get.currentRoute, route);
    //expect(find.text(pageTitle), findsOneWidget);
  });
  testWidgets('Should change page', (WidgetTester tester) async {
    // Arrange
    presenter.mockMethods();
    await loadPage(tester);
    // Act
    presenter.navigateToController.add('');
    await tester.pump();
    // Assert
    expect(Get.currentRoute, '/');
  });
}
