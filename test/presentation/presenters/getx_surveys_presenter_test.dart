import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/presentation/presenters/getx_surveys_presenter.dart';

import '../mocks/load_surveys_spy.dart';

void main() {
  test('Should call loadSurveys on loadData', () async {
    final loadSurveys = LoadSurveysSpy();
    final sut = GetxSurveysPresenter(loadSurveys: loadSurveys);

    await sut.loadData();

    verify(() => loadSurveys.load()).called(1);
  });
}
