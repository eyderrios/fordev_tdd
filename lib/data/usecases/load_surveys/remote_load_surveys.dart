import '../../../domain/entities/entities.dart';
import '../../http/http_client.dart';
import '../../models/models.dart';

class RemoteLoadSurveys {
  final String url;
  final HttpClient<List<HttpClientBody>> httpClient;

  RemoteLoadSurveys({
    required this.url,
    required this.httpClient,
  });

  Future<List<SurveyEntity>> load() async {
    final response = await httpClient.request(url: url, method: 'get');
    return response!
        .map((json) => RemoteSurveyModel.fromJson(json).toEntity())
        .toList();
  }
}
