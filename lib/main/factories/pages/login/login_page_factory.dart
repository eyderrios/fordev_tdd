import 'package:flutter/widgets.dart';

import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

class LoginPageFactory {
  static Widget makeLoginPage() {
    return LoginPage(LoginPresenterFactory.makeStreamLoginPresenter());
  }
}
