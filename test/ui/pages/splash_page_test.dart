import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ForDev')),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

void main() {
  Future<void> loadPage(WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => const SplashPage()),
        ],
      ),
    );
  }

  testWidgets('Should present spinner on page load',
      (WidgetTester tester) async {
    // Arrange
    await loadPage(tester);
    // Act

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
