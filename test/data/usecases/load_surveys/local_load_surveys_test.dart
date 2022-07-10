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
    if (data.isEmpty) {
      throw DomainError.unexpected;
    }
    return data
        .map<SurveyEntity>((map) => LocalSurveyModel.fromJson(map).toEntity())
        .toList();
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
  late List<Map> dataMap;
  late List<SurveyEntity> dataEntity;

  setUp(() {
    fetchCacheStorage = FetchCacheStorageSpy();
    sut = LocalLoadSurveys(fetchCacheStorage: fetchCacheStorage);
    dataMap = [
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
    dataEntity = dataMap
        .map<SurveyEntity>((map) => LocalSurveyModel.fromJson(map).toEntity())
        .toList();
  });

  test('Should call FetchCacheStorage with correct key', () async {
    // Arrange
    fetchCacheStorage.mockFetch(key: LocalLoadSurveys.surveysKey);
    // Act
    await sut.load();
    // Assert
    verify(() => fetchCacheStorage.fetch(LocalLoadSurveys.surveysKey))
        .called(1);
  });

  test('Should return a list of surveys on success', () async {
    // Arrange
    fetchCacheStorage.mockFetch(data: dataMap);
    // Act
    final surveys = await sut.load();
    // Assert
    expect(surveys, dataEntity);
  });

  test('Should throw UenexpectedError if cache is empty', () async {
    // Arrange
    fetchCacheStorage.mockFetch(data: []);
    // Act
    final future = sut.load();
    // Assert
    expect(future, throwsA(DomainError.unexpected));
  });
}
