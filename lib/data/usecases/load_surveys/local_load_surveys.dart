// implements LoadSurveys
import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/domain_error.dart';
import '../../../domain/usecases/load_surveys.dart';
import '../../cache/fetch_cache_storage.dart';
import '../../models/load_survey_model.dart';

class LocalLoadSurveys implements LoadSurveys {
  static const surveysKey = 'surveys';

  final FetchCacheStorage fetchCacheStorage;

  LocalLoadSurveys({required this.fetchCacheStorage});

  @override
  Future<List<SurveyEntity>> load() async {
    try {
      final data = await fetchCacheStorage.fetch(surveysKey);
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
