import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fordev_tdd/ui/helpers/errors/ui_error.dart';
import 'package:fordev_tdd/ui/helpers/i18n/i18n.dart';
import 'package:fordev_tdd/ui/pages/surveys/surveys.dart';
import 'package:get/get.dart';

import 'package:fordev_tdd/main/apps/app_routes.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

void main() {
  late SurveysPresenterSpy presenter;
  late List<SurveyViewModel> surveysList;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = SurveysPresenterSpy();
    final surveysPage = GetMaterialApp(
      initialRoute: AppRoutes.surveys,
      getPages: [
        GetPage(name: AppRoutes.surveys, page: () => SurveysPage(presenter)),
      ],
    );
    surveysList = [
      SurveyViewModel(
        id: '1',
        question: 'Question 1',
        date: 'some_date_1',
        didAnswer: true,
      ),
      SurveyViewModel(
        id: '2',
        question: 'Question 2',
        date: 'some_date_2',
        didAnswer: false,
      ),
    ];

    await tester.pumpWidget(surveysPage);
  }

  testWidgets('Should call LoadSurveys on page load',
      (WidgetTester tester) async {
    // Arrange
    await loadPage(tester);
    // Assert
    verify(() => presenter.loadData()).called(1);
  });

  testWidgets('Should handle loading correctly', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitIsLoading(true);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    presenter.emitIsLoading(false);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should present error is loadSurveysStream fails',
      (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitLoadSurveysError(UIError.unexpected.description);
    await tester.pump();
    expect(find.text(UIError.unexpected.description), findsOneWidget);
    expect(find.text(R.strings.reload), findsOneWidget);
    expect(find.text('Question 1'), findsNothing);
  });

  testWidgets('Should list of surveys is loadSurveysStream succeed',
      (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitLoadSurveys(surveysList);
    await tester.pump();

    expect(find.text(UIError.unexpected.description), findsNothing);
    expect(find.text(R.strings.reload), findsNothing);
    expect(find.text(surveysList[0].question), findsWidgets);
    expect(find.text(surveysList[1].question), findsWidgets);
  });
}
