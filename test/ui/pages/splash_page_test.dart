import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

class SplashPage extends StatelessWidget {
  final SplashPresenter presenter;

  const SplashPage({Key? key, required this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    presenter.loadCurrentAccount();
    return Scaffold(
      appBar: AppBar(title: const Text('ForDev')),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

abstract class SplashPresenter {
  Future<void> loadCurrentAccount();
}

class SplashPresenterSpy extends Mock implements SplashPresenter {
  void mockLoadCurrentAccount() {
    when(() => loadCurrentAccount()).thenAnswer((invocation) async => () {});
  }
}

void main() {
  late SplashPresenterSpy presenter;

  setUp(() {
    presenter = SplashPresenterSpy();
  });

  Future<void> loadPage(WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => SplashPage(presenter: presenter)),
        ],
      ),
    );
  }

  testWidgets('Should present spinner on page load',
      (WidgetTester tester) async {
    // Arrange
    presenter.mockLoadCurrentAccount();
    // Act
    await loadPage(tester);
    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should call loadCurrentAccount on page load',
      (WidgetTester tester) async {
    // Arrange
    presenter.mockLoadCurrentAccount();
    // Act
    await loadPage(tester);
    // Assert
    verify(() => presenter.loadCurrentAccount()).called(1);
  });
}
