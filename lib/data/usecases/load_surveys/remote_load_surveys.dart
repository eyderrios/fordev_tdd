import 'package:fordev_tdd/domain/usecases/usecases.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/domain_error.dart';
import '../../http/http.dart';
import '../../models/models.dart';

typedef RemoteLoadSurveysResponse = List<Map<String, dynamic>>;

class RemoteLoadSurveys implements LoadSurveys {
  final HttpClient httpClient;
  final String url;

  RemoteLoadSurveys({
    required this.url,
    required this.httpClient,
  });

  @override
  Future<List<SurveyEntity>> load() async {
    try {
      final response = await httpClient.request(url: url, method: 'get');
      return response
          .map<SurveyEntity>(
              (json) => RemoteSurveyModel.fromJson(json).toEntity())
          .toList();
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }
}
