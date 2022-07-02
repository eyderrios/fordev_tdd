import 'package:get/get.dart';

import '../../domain/usecases/load_current_account.dart';
import '../../main/apps/app_routes.dart';
import '../../ui/pages/splash/splash_presenter.dart';

class GetxSplashPresenter implements SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount;
  final _navigateTo = RxString('');

  GetxSplashPresenter({required this.loadCurrentAccount});

  @override
  Stream<String> get navigateToStream => _navigateTo.stream;

  @override
  Future<void> checkAccount({int durationInSeconds = 2}) async {
    await Future.delayed(Duration(seconds: durationInSeconds));
    try {
      final account = await loadCurrentAccount.load();
      _navigateTo.value =
          (account == null) ? AppRoutes.login : AppRoutes.surveys;
    } catch (error) {
      _navigateTo.value = AppRoutes.login;
    }
    return Future<void>(() {});
  }
}
