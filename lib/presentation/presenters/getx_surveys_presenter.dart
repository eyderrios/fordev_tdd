import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../domain/usecases/usecases.dart';
import '../../ui/pages/surveys/survey_view_model.dart';

class GetxSurveysPresenter {
  final _isLoading = RxBool(true);
  final _surveys = Rx<List<SurveyViewModel>>([]);

  final LoadSurveys loadSurveys;

  GetxSurveysPresenter({required this.loadSurveys});

  Stream<bool> get isLoadingStream => _isLoading.stream;
  Stream<List<SurveyViewModel>> get surveysStream => _surveys.stream;

  Future<void> loadData() async {
    _isLoading.value = true;
    final surveys = await loadSurveys.load();
    _surveys.value = surveys
        .map((survey) => SurveyViewModel(
              id: survey.id,
              question: survey.question,
              date: DateFormat('dd MMM yyyy').format(survey.dateTime),
              didAnswer: survey.didAnswer,
            ))
        .toList();
    _isLoading.value = false;
  }
}
