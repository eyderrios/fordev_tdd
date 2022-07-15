import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/data/usecases/load_surveys/remote_load_surveys.dart';

class RemoteLoadSurveysWithLocalFallback {
  final RemoteLoadSurveys remote;

  RemoteLoadSurveysWithLocalFallback({
    required this.remote,
  });

  Future<void> load() async {
    await remote.load();
    return Future<void>(() {});
  }
}

class RemoteLoadSurveysSpy extends Mock implements RemoteLoadSurveys {
  void mockLoad() {
    when(() => load()).thenAnswer((_) async => []);
  }
}

void main() {
  late RemoteLoadSurveysWithLocalFallback sut;
  late RemoteLoadSurveysSpy remote;

  setUp(() {
    remote = RemoteLoadSurveysSpy();
    sut = RemoteLoadSurveysWithLocalFallback(remote: remote);
  });

  test('Should call remote load', () async {
    // Arrange
    remote.mockLoad();
    // Act
    await sut.load();
    // Assert
    verify(() => remote.load()).called(1);
  });
}
