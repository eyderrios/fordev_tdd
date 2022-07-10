import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../domain/helpers/domain_error.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/helpers/errors/ui_error.dart';
import '../../ui/pages/surveys/survey_view_model.dart';
import '../../ui/pages/surveys/surveys_presenter.dart';

class GetxSurveysPresenter implements SurveysPresenter {
  final _surveys = Rx<List<SurveyViewModel>>([]);

  final LoadSurveys loadSurveys;

  GetxSurveysPresenter({required this.loadSurveys});

  @override
  Stream<List<SurveyViewModel>> get surveysStream => _surveys.stream;

  @override
  Future<void> loadData() async {
    try {
      final surveys = await loadSurveys.load();
      _surveys.value = surveys
          .map((survey) => SurveyViewModel(
                id: survey.id,
                question: survey.question,
                date: DateFormat('dd MMM yyyy').format(survey.dateTime),
                didAnswer: survey.didAnswer,
              ))
          .toList();
    } on DomainError {
      _surveys.subject
          .addError(UIError.unexpected.description, StackTrace.empty);
    }
  }
}
