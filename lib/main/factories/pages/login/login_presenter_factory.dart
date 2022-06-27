import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

class LoginPresenterFactory {
  static LoginPresenter makeStreamLoginPresenter() => StreamLoginPresenter(
        validator: LoginValidatorFactory.makeLoginValidator(),
        authentication: AuthenticationFactory.makeRemoteAuthentication(),
      );

  static LoginPresenter makeGetxLoginPresenter() => GetxLoginPresenter(
        validator: LoginValidatorFactory.makeLoginValidator(),
        authentication: AuthenticationFactory.makeRemoteAuthentication(),
      );
}
