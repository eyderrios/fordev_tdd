import 'package:faker/faker.dart';
import 'package:fordev_tdd/ui/helpers/errors/ui_error.dart';
import 'package:fordev_tdd/ui/pages/surveys/surveys.dart';
import 'package:intl/intl.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/domain/entities/survey_entity.dart';
import 'package:fordev_tdd/presentation/presenters/getx_surveys_presenter.dart';

import '../mocks/load_surveys_spy.dart';

void main() {
  const surveysCount = 4;
  late GetxSurveysPresenter sut;
  late LoadSurveysSpy loadSurveys;
  late List<SurveyEntity> surveysEntities;
  late List<SurveyViewModel> surveysModels;

  setUp(() {
    loadSurveys = LoadSurveysSpy();
    sut = GetxSurveysPresenter(loadSurveys: loadSurveys);
    surveysEntities = List<SurveyEntity>.generate(
      surveysCount,
      (index) => SurveyEntity(
        id: faker.guid.guid(),
        question: faker.lorem.sentence(),
        dateTime: faker.date.dateTime(),
        didAnswer: faker.randomGenerator.boolean(),
      ),
    );
    surveysModels = List<SurveyViewModel>.generate(
      surveysEntities.length,
      (index) => SurveyViewModel(
        id: surveysEntities[index].id,
        question: surveysEntities[index].question,
        date: DateFormat('dd MMM yyyy').format(surveysEntities[index].dateTime),
        didAnswer: surveysEntities[index].didAnswer,
      ),
    );
  });

  test('Should call loadSurveys on loadData', () async {
    loadSurveys.mockLoad(surveysEntities);

    await sut.loadData();

    verify(() => loadSurveys.load()).called(1);
  });

  test('Should emit correct events on success', () async {
    loadSurveys.mockLoad(surveysEntities);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.surveysStream
        .listen(expectAsync1((surveys) => expect(surveys, surveysModels)));

    await sut.loadData();
  });

  test('Should emit correct events on failure', () async {
    loadSurveys.mockLoad(surveysEntities);
    loadSurveys.mockLoadError();

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.surveysStream.listen(null,
        onError: expectAsync2(
            (error, _) => expect(error, UIError.unexpected.description)));

    await sut.loadData();
  });
}
