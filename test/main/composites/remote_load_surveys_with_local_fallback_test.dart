import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/domain/helpers/helpers.dart';
import 'package:fordev_tdd/main/composites/remote_load_surveys_with_local_fallback.dart';
import 'package:fordev_tdd/domain/entities/survey_entity.dart';

import '../mocks/local_load_survey_spy.dart';
import '../mocks/remote_load_surveys_spy.dart';

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

  test('Should throw UnexpectedError if remote and local load throws',
      () async {
    // Arrange
    remote.mockLoadError(DomainError.unexpected);
    local.mockLocalLoadError();
    local.mockValidate();

    // Act
    final future = sut.load();
    // Assert
    expect(future, throwsA(DomainError.unexpected));
  });
}
