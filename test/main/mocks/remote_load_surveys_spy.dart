import 'package:fordev_tdd/data/usecases/load_surveys/load_surveys.dart';
import 'package:fordev_tdd/domain/entities/entities.dart';
import 'package:fordev_tdd/domain/helpers/helpers.dart';
import 'package:mocktail/mocktail.dart';

class RemoteLoadSurveysSpy extends Mock implements RemoteLoadSurveys {
  When _mockLoadCall() => when(() => load());

  void mockLoad(List<SurveyEntity> values) {
    _mockLoadCall().thenAnswer((_) async => values);
  }

  void mockLoadError(DomainError error) {
    _mockLoadCall().thenThrow(error);
  }
}
