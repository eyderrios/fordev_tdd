import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:fordev_tdd/main/apps/app_routes.dart';
import 'package:fordev_tdd/ui/pages/surveys/surveys_page.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

void main() {
  testWidgets('Should call LoadSurveys on page load',
      (WidgetTester tester) async {
    final presenter = SurveysPresenterSpy();
    final surveysPage = GetMaterialApp(
      initialRoute: AppRoutes.surveys,
      getPages: [
        GetPage(name: AppRoutes.surveys, page: () => SurveysPage(presenter)),
      ],
    );
    // Arrange
    presenter.mockLoadData();
    // Act
    await tester.pumpWidget(surveysPage);
    // Assert
    verify(() => presenter.loadData()).called(1);
  });
}
