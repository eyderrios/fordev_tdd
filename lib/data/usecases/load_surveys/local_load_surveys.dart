import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/domain_error.dart';
import '../../../domain/usecases/load_surveys.dart';
import '../../cache/cache_storage.dart';
import '../../models/load_survey_model.dart';

class LocalLoadSurveys implements LoadSurveys {
  static const surveysKey = 'surveys';

  final CacheStorage cacheStorage;

  LocalLoadSurveys({required this.cacheStorage});

  List<SurveyEntity> _mapToEntity(List<Map> list) => list
      .map<SurveyEntity>((map) => LocalSurveyModel.fromJson(map).toEntity())
      .toList();

  void _validateCache(List<Map> list) => _mapToEntity(list);

  @override
  Future<List<SurveyEntity>> load() async {
    try {
      final data = await cacheStorage.fetch(surveysKey);
      if (data?.isEmpty != false) {
        throw Exception();
      }
      return _mapToEntity(data);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }

  Future<void> validate() async {
    final data = await cacheStorage.fetch(surveysKey);
    try {
      _validateCache(data);
    } catch (error) {
      await cacheStorage.delete(surveysKey);
    }
    return Future<void>(() {});
  }
}
