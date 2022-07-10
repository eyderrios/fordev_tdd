import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/data/usecases/load_surveys/load_surveys.dart';
import 'package:fordev_tdd/data/models/models.dart';
import 'package:fordev_tdd/domain/entities/survey_entity.dart';
import 'package:fordev_tdd/domain/helpers/domain_error.dart';

import '../../mocks/cache_storage_spy.dart';

void main() {
  group('LOAD', () {
    late LocalLoadSurveys sut;
    late CacheStorageSpy cache;
    late List<Map> validMap;
    late List<Map> invalidMap;
    late List<Map> incompleteMap;
    late List<SurveyEntity> validEntities;

    setUp(() {
      cache = CacheStorageSpy();
      sut = LocalLoadSurveys(cacheStorage: cache);
      validMap = [
        {
          'id': faker.guid.guid(),
          'question': faker.randomGenerator.string(50),
          'date': faker.date.dateTime().toIso8601String(),
          'didAnswer': 'false',
        },
        {
          'id': faker.guid.guid(),
          'question': faker.randomGenerator.string(50),
          'date': faker.date.dateTime().toIso8601String(),
          'didAnswer': 'true',
        }
      ];
      invalidMap = [
        {
          'id': faker.guid.guid(),
          'question': faker.randomGenerator.string(50),
          'date': 'invalid_date',
          'didAnswer': 'false',
        }
      ];
      incompleteMap = [
        {
          'date': faker.date.dateTime().toIso8601String(),
          'didAnswer': 'false',
        }
      ];
      validEntities = validMap
          .map<SurveyEntity>((map) => LocalSurveyModel.fromMap(map).toEntity())
          .toList();
    });

    test('Should call CacheStorage with correct key', () async {
      // Arrange
      cache.mockFetch(key: LocalLoadSurveys.surveysKey, data: validMap);
      // Act
      await sut.load();
      // Assert
      verify(() => cache.fetch(LocalLoadSurveys.surveysKey)).called(1);
    });

    test('Should return a list of surveys on success', () async {
      // Arrange
      cache.mockFetch(data: validMap);
      // Act
      final surveys = await sut.load();
      // Assert
      expect(surveys, validEntities);
    });

    test('Should throw UenexpectedError if cache is empty', () async {
      // Arrange
      cache.mockFetch(data: []);
      // Act
      final future = sut.load();
      // Assert
      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UenexpectedError if cache is null', () async {
      // Arrange
      cache.mockFetch(data: null);
      // Act
      final future = sut.load();
      // Assert
      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UenexpectedError if cache is invalid', () async {
      // Arrange
      cache.mockFetch(data: invalidMap);
      // Act
      final future = sut.load();
      // Assert
      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache is incomplete (missing fields)',
        () async {
      // Arrange
      cache.mockFetch(data: incompleteMap);
      // Act
      final future = sut.load();
      // Assert
      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache is incomplete (missing fields)',
        () async {
      // Arrange
      cache.mockFetchError();
      // Act
      final future = sut.load();
      // Assert
      expect(future, throwsA(DomainError.unexpected));
    });
  });

  group('VALIDATE', () {
    late LocalLoadSurveys sut;
    late CacheStorageSpy cache;
    late List<Map> validMap;
    late List<Map> invalidMap;
    late List<Map> incompleteMap;

    setUp(() {
      cache = CacheStorageSpy();
      sut = LocalLoadSurveys(cacheStorage: cache);
      validMap = [
        {
          'id': faker.guid.guid(),
          'question': faker.randomGenerator.string(50),
          'date': faker.date.dateTime().toIso8601String(),
          'didAnswer': 'false',
        },
        {
          'id': faker.guid.guid(),
          'question': faker.randomGenerator.string(50),
          'date': faker.date.dateTime().toIso8601String(),
          'didAnswer': 'true',
        }
      ];
      invalidMap = [
        {
          'id': faker.guid.guid(),
          'question': faker.randomGenerator.string(50),
          'date': 'invalid_date',
          'didAnswer': 'false',
        }
      ];
      incompleteMap = [
        {
          'date': faker.date.dateTime().toIso8601String(),
          'didAnswer': 'false',
        }
      ];
    });

    test('Should call CacheStorage with correct key', () async {
      // Arrange
      cache.mockFetch(key: LocalLoadSurveys.surveysKey, data: validMap);
      // Act
      await sut.validate();
      // Assert
      verify(() => cache.fetch(LocalLoadSurveys.surveysKey)).called(1);
    });

    test('Should empty cache if it is invaid', () async {
      // Arrange
      cache.mockFetch(key: LocalLoadSurveys.surveysKey, data: invalidMap);
      cache.mockDelete();
      // Act
      await sut.validate();
      // Assert
      verify(() => cache.delete(LocalLoadSurveys.surveysKey)).called(1);
    });

    test('Should empty cache if it is incomplete', () async {
      // Arrange
      cache.mockFetch(key: LocalLoadSurveys.surveysKey, data: incompleteMap);
      cache.mockDelete();
      // Act
      await sut.validate();
      // Assert
      verify(() => cache.delete(LocalLoadSurveys.surveysKey)).called(1);
    });

    test('Should empty cache if CacheStorage throws', () async {
      // Arrange
      cache.mockFetchError();
      cache.mockDelete();
      // Act
      await sut.validate();
      // Assert
      verify(() => cache.delete(LocalLoadSurveys.surveysKey)).called(1);
    });
  });

  group('SAVE', () {
    late LocalLoadSurveys sut;
    late CacheStorageSpy cache;
    late List<Map<String, String>> validMap;
    late List<SurveyEntity> validEntities;

    setUp(() {
      cache = CacheStorageSpy();
      sut = LocalLoadSurveys(cacheStorage: cache);
      validMap = [
        {
          'id': faker.guid.guid(),
          'question': faker.randomGenerator.string(50),
          'date': faker.date.dateTime().toIso8601String(),
          'didAnswer': 'false',
        },
        {
          'id': faker.guid.guid(),
          'question': faker.randomGenerator.string(50),
          'date': faker.date.dateTime().toIso8601String(),
          'didAnswer': 'true',
        }
      ];
      validEntities = validMap
          .map<SurveyEntity>((map) => LocalSurveyModel.fromMap(map).toEntity())
          .toList();
    });

    test('Should call CacheStorage with correct params', () async {
      // Arrange
      cache.mockSave(key: LocalLoadSurveys.surveysKey, value: validMap);
      // Act
      await sut.save(validEntities);
      // Assert
      verify(() =>
              cache.save(key: LocalLoadSurveys.surveysKey, value: validMap))
          .called(1);
    });

    test('Should throws UnexpectedError if save() throws', () async {
      // Arrange
      cache.mockSaveError();
      // Act
      final future = sut.save(validEntities);
      // Assert
      expect(future, throwsA(DomainError.unexpected));
    });
  });
}
