import 'dart:async';
import 'package:mocktail/mocktail.dart';

import 'package:fordev_tdd/ui/pages/splash/splash_presenter.dart';

class SplashPresenterSpy extends Mock implements SplashPresenter {
  final navigateToController = StreamController<String>();

  void mockMethods() {
    mockNavigateToStream();
    mockLoadCurrentAccount();
  }

  void mockNavigateToStream() {
    when(() => navigateToStream).thenAnswer((_) => navigateToController.stream);
  }

  void mockLoadCurrentAccount() {
    when(() => loadCurrentAccount()).thenAnswer((invocation) async => () {});
  }
}
