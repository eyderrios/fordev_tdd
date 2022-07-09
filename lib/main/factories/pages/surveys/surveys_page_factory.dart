import 'package:flutter/material.dart';

import '../../../../ui/pages/surveys/surveys_page.dart';
import 'surveys_presenter_factory.dart';

class SurveysPageFactory {
  static Widget makeSurveysPage() => SurveysPage(
        SurveysPresenterFactory.makeGetxSurveysPresenter(),
      );
}
