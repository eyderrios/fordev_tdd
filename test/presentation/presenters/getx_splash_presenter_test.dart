import 'package:fordev_tdd/domain/entities/account_entity.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/domain/usecases/load_current_account.dart';
import 'package:fordev_tdd/main/apps/app_routes.dart';
import 'package:fordev_tdd/ui/pages/splash/splash.dart';

import '../../domain/mocks/entity_factory.dart';

class GetxSplashPresenter implements SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount;
  final _navigateTo = RxString('');

  GetxSplashPresenter({required this.loadCurrentAccount});

  @override
  Stream<String> get navigateToStream => _navigateTo.stream;

  @override
  Future<void> checkAccount() async {
    final account = await loadCurrentAccount.load();
    _navigateTo.value = (account == null) ? AppRoutes.login : AppRoutes.surveys;
    return Future<void>(() {});
  }
}

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {
  void mockLoad({required AccountEntity? account}) {
    when(() => load())
        .thenAnswer((_) async => (account != null) ? account : null);
  }
}

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
    await sut.checkAccount();
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
    await sut.checkAccount();
  });

  test('Should go to login page on null result', () async {
    // Arrange
    loadCurrentAccount.mockLoad(account: null);
    // Late Assert
    sut.navigateToStream
        .listen(expectAsync1((page) => expect(page, AppRoutes.login)));
    // Act
    await sut.checkAccount();
  });
}
