import 'package:fordev_tdd/domain/entities/survey_entity.dart';
import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/domain/usecases/load_surveys.dart';

class LoadSurveysSpy extends Mock implements LoadSurveys {
  LoadSurveysSpy() {
    _mockMethods();
  }

  void _mockMethods() {
    when(() => load()).thenAnswer((_) async => List<SurveyEntity>.empty());
  }
}
