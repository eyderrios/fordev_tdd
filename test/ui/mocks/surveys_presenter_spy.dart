import 'dart:async';

import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/ui/pages/surveys/surveys.dart';

class SurveysPresenterSpy extends Mock implements SurveysPresenter {
  final _isLoadingController = StreamController<bool>();
  final _loadSurveysController = StreamController<List<SurveyViewModel>>();

  SurveysPresenterSpy() {
    _mockMethods();
  }

  void _mockMethods() {
    when(() => loadData()).thenAnswer((_) async => _);

    when(() => isLoadingStream).thenAnswer((_) => _isLoadingController.stream);
    when(() => loadSurveysStream)
        .thenAnswer((_) => _loadSurveysController.stream);
  }

  void emitIsLoading(bool flag) => _isLoadingController.add(flag);
  void emitLoadSurveysError(String error) =>
      _loadSurveysController.addError(error);
}
