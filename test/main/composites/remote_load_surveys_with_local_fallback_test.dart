import 'package:faker/faker.dart';
import 'package:fordev_tdd/domain/helpers/helpers.dart';
import 'package:fordev_tdd/domain/usecases/load_surveys.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/data/usecases/load_surveys/load_surveys.dart';
import 'package:fordev_tdd/domain/entities/survey_entity.dart';

class RemoteLoadSurveysWithLocalFallback implements LoadSurveys {
  final RemoteLoadSurveys remote;
  final LocalLoadSurveys local;

  RemoteLoadSurveysWithLocalFallback({
    required this.remote,
    required this.local,
  });

  @override
  Future<List<SurveyEntity>> load() async {
    List<SurveyEntity> response;

    try {
      response = await remote.load();
      await local.save(response);
      return response;
    } catch (error) {
      if (error == DomainError.accessDenied) {
        rethrow;
      }
      await local.validate();
      response = await local.load();
    }
    return response;
  }
}

class RemoteLoadSurveysSpy extends Mock implements RemoteLoadSurveys {
  When _mockLoadCall() => when(() => load());

  void mockLoad(List<SurveyEntity> values) {
    _mockLoadCall().thenAnswer((_) async => values);
  }

  void mockLoadError(DomainError error) {
    _mockLoadCall().thenThrow(error);
  }
}

class LocalLoadSurveysSpy extends Mock implements LocalLoadSurveys {
  When _mockValidateCall() => when(() => validate());

  void mockSave(List<SurveyEntity> values) {
    when(() => save(values)).thenAnswer((_) async => values);
  }

  void mockLoad(List<SurveyEntity> values) {
    when(() => load()).thenAnswer((_) async => values);
  }

  void mockValidate() {
    _mockValidateCall().thenAnswer((_) async => _);
  }
}

void main() {
  late RemoteLoadSurveysWithLocalFallback sut;
  late RemoteLoadSurveysSpy remote;
  late LocalLoadSurveysSpy local;
  late List<SurveyEntity> remoteSurveys;
  late List<SurveyEntity> localSurveys;

  setUp(() {
    remote = RemoteLoadSurveysSpy();
    local = LocalLoadSurveysSpy();
    sut = RemoteLoadSurveysWithLocalFallback(remote: remote, local: local);
    remoteSurveys = [
      SurveyEntity(
        id: faker.guid.guid(),
        question: faker.randomGenerator.string(50),
        dateTime: faker.date.dateTime(),
        didAnswer: faker.randomGenerator.boolean(),
      ),
    ];
    localSurveys = remoteSurveys;
  });

  test('Should call remote load', () async {
    // Arrange
    remote.mockLoad(remoteSurveys);
    local.mockValidate();
    local.mockSave(remoteSurveys);
    // Act
    await sut.load();
    // Assert
    verify(() => remote.load()).called(1);
  });

  test('Should call local save with remote data', () async {
    // Arrange
    remote.mockLoad(remoteSurveys);
    local.mockSave(remoteSurveys);
    // Act
    await sut.load();
    // Assert
    verify(() => local.save(remoteSurveys)).called(1);
  });

  test('Should return remote data', () async {
    // Arrange
    remote.mockLoad(remoteSurveys);
    local.mockSave(remoteSurveys);
    // Act
    final surveys = await sut.load();
    // Assert
    expect(surveys, remoteSurveys);
  });

  test('Should rethrow if remote load throws AccessDeniedError', () async {
    // Arrange
    remote.mockLoadError(DomainError.accessDenied);
    // Act
    final future = sut.load();
    // Assert
    expect(future, throwsA(DomainError.accessDenied));
  });

  test('Should call load fetch on remote error', () async {
    // Arrange
    remote.mockLoadError(DomainError.unexpected);
    local.mockValidate();
    local.mockLoad(localSurveys);
    // Act
    await sut.load();
    // Assert
    verify(() => local.validate()).called(1);
    verify(() => local.load()).called(1);
  });

  test('Should return local stored surveys', () async {
    // Arrange
    remote.mockLoadError(DomainError.unexpected);
    local.mockValidate();
    local.mockLoad(localSurveys);
    // Act
    final surveys = await sut.load();
    // Assert
    expect(surveys, localSurveys);
  });
}
