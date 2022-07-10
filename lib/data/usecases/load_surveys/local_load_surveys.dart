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
      .map<SurveyEntity>((map) => LocalSurveyModel.fromMap(map).toEntity())
      .toList();

  List<Map<String, String>> _entityToMap(List<SurveyEntity> list) => list
      .map<Map<String, String>>(
          (entity) => LocalSurveyModel.fromEntity(entity).toMap())
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
    try {
      final data = await cacheStorage.fetch(surveysKey);
      _validateCache(data);
    } catch (error) {
      cacheStorage.delete(surveysKey);
    }
    return Future<void>(() {});
  }

  Future<void> save(List<SurveyEntity> surveys) async {
    await cacheStorage.save(key: surveysKey, value: _entityToMap(surveys));
    return Future<void>(() {});
  }
}
