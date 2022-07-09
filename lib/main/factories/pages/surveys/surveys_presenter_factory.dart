import '../../../../presentation/presenters/getx_surveys_presenter.dart';
import '../../../../ui/pages/surveys/surveys.dart';
import '../../factories.dart';

class SurveysPresenterFactory {
  static SurveysPresenter makeGetxSurveysPresenter() => GetxSurveysPresenter(
      loadSurveys: LoadSurveysFactory.makeRemoteLoadSurveys());
}
