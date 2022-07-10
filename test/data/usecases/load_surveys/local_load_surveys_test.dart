import 'package:faker/faker.dart';
import 'package:fordev_tdd/data/models/models.dart';
import 'package:fordev_tdd/domain/entities/survey_entity.dart';
import 'package:fordev_tdd/domain/helpers/domain_error.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// implements LoadSurveys
class LocalLoadSurveys {
  static const surveysKey = 'surveys';

  final FetchCacheStorage fetchCacheStorage;

  LocalLoadSurveys({required this.fetchCacheStorage});

  Future<List<SurveyEntity>> load() async {
    final data = await fetchCacheStorage.fetch(surveysKey);
    try {
      if (data?.isEmpty != false) {
        throw Exception();
      }
      return data
          .map<SurveyEntity>((map) => LocalSurveyModel.fromJson(map).toEntity())
          .toList();
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}

class FetchCacheStorageSpy extends Mock implements FetchCacheStorage {
  void mockFetch({
    String? key,
    List<Map>? data,
  }) {
    when(() => fetch(key ?? any())).thenAnswer((_) async => data ?? []);
  }
}

abstract class FetchCacheStorage {
  Future<dynamic> fetch(String key);
}

void main() {
  late LocalLoadSurveys sut;
  late FetchCacheStorageSpy fetchCacheStorage;
  late List<Map> validMap;
  late List<Map> invalidMap;
  late List<Map> incompleteMap;
  late List<SurveyEntity> validEntities;

  setUp(() {
    fetchCacheStorage = FetchCacheStorageSpy();
    sut = LocalLoadSurveys(fetchCacheStorage: fetchCacheStorage);
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
        .map<SurveyEntity>((map) => LocalSurveyModel.fromJson(map).toEntity())
        .toList();
  });

  test('Should call FetchCacheStorage with correct key', () async {
    // Arrange
    fetchCacheStorage.mockFetch(
        key: LocalLoadSurveys.surveysKey, data: validMap);
    // Act
    await sut.load();
    // Assert
    verify(() => fetchCacheStorage.fetch(LocalLoadSurveys.surveysKey))
        .called(1);
  });

  test('Should return a list of surveys on success', () async {
    // Arrange
    fetchCacheStorage.mockFetch(data: validMap);
    // Act
    final surveys = await sut.load();
    // Assert
    expect(surveys, validEntities);
  });

  test('Should throw UenexpectedError if cache is empty', () async {
    // Arrange
    fetchCacheStorage.mockFetch(data: []);
    // Act
    final future = sut.load();
    // Assert
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UenexpectedError if cache is null', () async {
    // Arrange
    fetchCacheStorage.mockFetch(data: null);
    // Act
    final future = sut.load();
    // Assert
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UenexpectedError if cache is invalid', () async {
    // Arrange
    fetchCacheStorage.mockFetch(data: invalidMap);
    // Act
    final future = sut.load();
    // Assert
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UenexpectedError if cache is incomplete (missing fields)',
      () async {
    // Arrange
    fetchCacheStorage.mockFetch(data: incompleteMap);
    // Act
    final future = sut.load();
    // Assert
    expect(future, throwsA(DomainError.unexpected));
  });
}
