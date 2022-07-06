import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/ui/pages/surveys/surveys.dart';

class SurveysPresenterSpy extends Mock implements SurveysPresenter {
  void mockLoadData() {
    when(() => loadData()).thenAnswer((_) async => _);
  }
}
