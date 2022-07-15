import 'package:fordev_tdd/data/usecases/load_surveys/local_load_surveys.dart';
import 'package:fordev_tdd/domain/entities/entities.dart';
import 'package:fordev_tdd/domain/helpers/helpers.dart';
import 'package:mocktail/mocktail.dart';

class LocalLoadSurveysSpy extends Mock implements LocalLoadSurveys {
  When _mockValidateCall() => when(() => validate());

  void mockSave(List<SurveyEntity> values) {
    when(() => save(values)).thenAnswer((_) async => values);
  }

  void mockLoad(List<SurveyEntity> values) {
    when(() => load()).thenAnswer((_) async => values);
  }

  void mockValidate() {
    _mockValidateCall().thenAnswer((_) async => _);
  }

  void mockLocalLoadError() {
    when(() => load()).thenThrow(DomainError.unexpected);
  }
}
