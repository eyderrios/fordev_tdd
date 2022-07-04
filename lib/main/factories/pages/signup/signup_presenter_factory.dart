import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

class SignUpPresenterFactory {
  static SignUpPresenter makeGetxSignUpPresenter() => GetxSignUpPresenter(
        addAccount: AddAccountFactory.makeRemoteAddAccount(),
        validator: SignUpValidatorFactory.makeSignUpValidator(),
        saveCurrentAccount:
            SaveCurrentAccountFactory.makeLocalSaveCurrentAccount(),
      );
}
