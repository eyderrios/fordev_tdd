import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';
import '../../usecases/load_current_account_factory.dart';

class SplashPresenterFactory {
  static SplashPresenter makeGetxSplashPresenter() => GetxSplashPresenter(
      loadCurrentAccount:
          LoadCurrentAccountFactory.makeLocalLoadCurrentAccount());
}
