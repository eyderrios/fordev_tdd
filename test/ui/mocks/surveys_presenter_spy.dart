import 'dart:async';

import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/ui/pages/surveys/surveys.dart';

class SurveysPresenterSpy extends Mock implements SurveysPresenter {
  final _surveysController = StreamController<List<SurveyViewModel>>();

  SurveysPresenterSpy() {
    _mockMethods();
  }

  void _mockMethods() {
    when(() => loadData()).thenAnswer((_) async => _);
    when(() => surveysStream).thenAnswer((_) => _surveysController.stream);
  }

  void emitLoadSurveys(List<SurveyViewModel> surveys) =>
      _surveysController.add(surveys);
  void emitLoadSurveysError(String error) => _surveysController.addError(error);
}
