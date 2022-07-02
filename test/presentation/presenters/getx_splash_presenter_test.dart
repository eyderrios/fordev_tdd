import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/domain/entities/account_entity.dart';
import 'package:fordev_tdd/presentation/presenters/getx_splash_presenter.dart';
import 'package:fordev_tdd/main/apps/app_routes.dart';

import '../../domain/mocks/entity_factory.dart';
import '../mocks/load_current_account_spy.dart';

void main() {
  late AccountEntity account;
  late LoadCurrentAccountSpy loadCurrentAccount;
  late GetxSplashPresenter sut;

  setUp(() {
    account = EntityFactory.makeAccountEntity();
    loadCurrentAccount = LoadCurrentAccountSpy();
    sut = GetxSplashPresenter(loadCurrentAccount: loadCurrentAccount);
  });

  test('Should call LoadCurrentAccount', () async {
    // Arrange
    loadCurrentAccount.mockLoad(account: account);
    // Act
    await sut.checkAccount(durationInSeconds: 0);
    // Assert
    verify(() => loadCurrentAccount.load()).called(1);
  });

  test('Should go to surveys page on success', () async {
    // Arrange
    loadCurrentAccount.mockLoad(account: account);
    // Late Assert
    sut.navigateToStream
        .listen(expectAsync1((page) => expect(page, AppRoutes.surveys)));
    // Act
    await sut.checkAccount(durationInSeconds: 0);
  });

  test('Should go to login page on null result', () async {
    // Arrange
    loadCurrentAccount.mockLoad(account: null);
    // Late Assert
    sut.navigateToStream
        .listen(expectAsync1((page) => expect(page, AppRoutes.login)));
    // Act
    await sut.checkAccount(durationInSeconds: 0);
  });

  test('Should go to login page on error', () async {
    // Arrange
    loadCurrentAccount.mockLoad(account: null);
    loadCurrentAccount.mockLoadError();
    // Late Assert
    sut.navigateToStream
        .listen(expectAsync1((page) => expect(page, AppRoutes.login)));
    // Act
    await sut.checkAccount(durationInSeconds: 0);
  });
}
