import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// implements LoadSurveys
class LocalLoadSurveys {
  static const surveysKey = 'surveys';

  final FetchCacheStorage fetchCacheStorage;

  LocalLoadSurveys({required this.fetchCacheStorage});

  Future<void> load() async {
    await fetchCacheStorage.fetch(surveysKey);
  }
}

class FetchCacheStorageSpy extends Mock implements FetchCacheStorage {
  void mockFetch({String? key}) {
    when(() => fetch(key ?? any())).thenAnswer((_) async => _);
  }
}

abstract class FetchCacheStorage {
  Future<void> fetch(String key);
}

void main() {
  late LocalLoadSurveys sut;
  late FetchCacheStorageSpy fetchCacheStorage;

  setUp(() {
    fetchCacheStorage = FetchCacheStorageSpy();
    sut = LocalLoadSurveys(fetchCacheStorage: fetchCacheStorage);
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
}
