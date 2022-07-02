import 'package:fordev_tdd/data/usecases/load_current_account/local_load_current_account.dart';
import 'package:fordev_tdd/main/factories/usecases/load_current_account_factory.dart';

import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';

class SplashPresenterFactory {
  static SplashPresenter makeGetxSplashPresenter() => GetxSplashPresenter(
      loadCurrentAccount:
          LoadCurrentAccountFactory.makeLocalLoadCurrentAccount());
}
