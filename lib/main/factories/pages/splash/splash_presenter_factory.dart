import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

class SplashPresenterFactory {
  static SplashPresenter makeGetxSplashPresenter() =>
      GetxSplashPresenter(loadCurrentAccount: loadCurrentAccount);
}
