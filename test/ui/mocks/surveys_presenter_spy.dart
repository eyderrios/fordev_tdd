import 'dart:async';

import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/ui/pages/surveys/surveys.dart';

class SurveysPresenterSpy extends Mock implements SurveysPresenter {
  final _isLoadingController = StreamController<bool>();
  final _surveysController = StreamController<List<SurveyViewModel>>();

  SurveysPresenterSpy() {
    _mockMethods();
  }

  void _mockMethods() {
    when(() => loadData()).thenAnswer((_) async => _);

    when(() => isLoadingStream).thenAnswer((_) => _isLoadingController.stream);
    when(() => surveysStream).thenAnswer((_) => _surveysController.stream);
  }

  void emitIsLoading(bool flag) => _isLoadingController.add(flag);
  void emitLoadSurveys(List<SurveyViewModel> surveys) =>
      _surveysController.add(surveys);
  void emitLoadSurveysError(String error) => _surveysController.addError(error);
}
