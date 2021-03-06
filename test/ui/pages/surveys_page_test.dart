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
      const SurveyViewModel(
        id: '1',
        question: 'Question 1',
        date: 'date_1',
        didAnswer: true,
      ),
      const SurveyViewModel(
        id: '2',
        question: 'Question 2',
        date: 'date_2',
        didAnswer: false,
      ),
    ];

    await tester.pumpWidget(surveysPage);
  }

  testWidgets('Should call loadSurveys on page load',
      (WidgetTester tester) async {
    // Arrange
    await loadPage(tester);
    // Assert
    verify(() => presenter.loadData()).called(1);
  });

  testWidgets('Should present error is surveysStream fails',
      (WidgetTester tester) async {
    await loadPage(tester);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    presenter.emitLoadSurveysError(UIError.unexpected.description);
    await tester.pump();

    expect(find.text(UIError.unexpected.description), findsOneWidget);
    expect(find.text(R.strings.reload), findsOneWidget);
    expect(find.text('Question 1'), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should list of surveys is surveysStream succeed',
      (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitLoadSurveys(surveysList);
    await tester.pump();

    expect(find.text(UIError.unexpected.description), findsNothing);
    expect(find.text(R.strings.reload), findsNothing);
    expect(find.text(surveysList[0].question), findsWidgets);
    expect(find.text(surveysList[0].date), findsWidgets);
    expect(find.text(surveysList[1].question), findsWidgets);
    expect(find.text(surveysList[1].date), findsWidgets);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should call loadSurveys on reload button click',
      (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitLoadSurveysError(UIError.unexpected.description);
    await tester.pump();
    await tester.tap(find.text(R.strings.reload));

    verify(() => presenter.loadData()).called(2);
  });
}
