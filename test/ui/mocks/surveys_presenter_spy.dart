import 'dart:async';

import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/ui/pages/surveys/surveys.dart';

class SurveysPresenterSpy extends Mock implements SurveysPresenter {
  final _isLoadingController = StreamController<bool>();

  SurveysPresenterSpy() {
    _mockMethods();
  }

  void _mockMethods() {
    when(() => loadData()).thenAnswer((_) async => _);

    when(() => isLoadingStream).thenAnswer((_) => _isLoadingController.stream);
  }

  void emitIsLoading(bool flag) => _isLoadingController.add(flag);
}
