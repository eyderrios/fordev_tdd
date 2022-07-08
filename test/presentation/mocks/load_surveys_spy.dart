import 'package:fordev_tdd/domain/entities/survey_entity.dart';
import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/domain/usecases/load_surveys.dart';

class LoadSurveysSpy extends Mock implements LoadSurveys {
  void mockLoad(List<SurveyEntity> surveys) {
    when(() => load()).thenAnswer((_) async => surveys);
  }
}
