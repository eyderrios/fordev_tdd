import 'package:fordev_tdd/domain/helpers/domain_error.dart';

import '../../../domain/entities/entities.dart';
import '../../http/http.dart';
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
    try {
      final response = await httpClient.request(url: url, method: 'get');
      return response!
          .map((json) => RemoteSurveyModel.fromJson(json).toEntity())
          .toList();
    } on HttpError {
      throw DomainError.unexpected;
    }
  }
}
