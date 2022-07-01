import 'package:fordev_tdd/domain/usecases/load_current_account.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

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
    await loadCurrentAccount.load();
    return Future<void>(() {});
  }
}

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {
  void mockLoad() {
    when(() => load())
        .thenAnswer((_) async => EntityFactory.makeAccountEntity());
  }
}

void main() {
  late LoadCurrentAccountSpy loadCurrentAccount;
  late GetxSplashPresenter sut;

  setUp(() {
    loadCurrentAccount = LoadCurrentAccountSpy();
    sut = GetxSplashPresenter(loadCurrentAccount: loadCurrentAccount);
  });

  test('Should call LoadCurrentAccount', () async {
    // Arrange
    loadCurrentAccount.mockLoad();
    // Act
    await sut.checkAccount();
    // Assert
    verify(() => loadCurrentAccount.load()).called(1);
  });
}
