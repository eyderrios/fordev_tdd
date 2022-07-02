import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

class LoginPresenterFactory {
  static LoginPresenter makeStreamLoginPresenter() => StreamLoginPresenter(
        validator: LoginValidatorFactory.makeLoginValidator(),
        authentication: AuthenticationFactory.makeRemoteAuthentication(),
      );

  static LoginPresenter makeGetxLoginPresenter() => GetxLoginPresenter(
        authentication: AuthenticationFactory.makeRemoteAuthentication(),
        validator: LoginValidatorFactory.makeLoginValidator(),
        saveCurrentAccount:
            SaveCurrentAccountFactory.makeLocalSaveCurrentAccount(),
      );
}
