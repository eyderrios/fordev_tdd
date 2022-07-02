import 'package:flutter/widgets.dart';

import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

class SplashPageFactory {
  static Widget makeSplashPage() {
    return SplashPage(
        presenter: SplashPresenterFactory.makeGetxSplashPresenter());
  }
}
