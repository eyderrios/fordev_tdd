import 'package:flutter/widgets.dart';

import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

class SignUpPageFactory {
  static Widget makeSignUpPage() {
    return SignUpPage(SignUpPresenterFactory.makeGetxSignUpPresenter());
  }
}
