import 'dart:async';

import 'package:fordev_tdd/ui/pages/surveys/surveys.dart';

abstract class SurveysPresenter {
  Stream<List<SurveyViewModel>> get surveysStream;

  Future<void> loadData();
}
