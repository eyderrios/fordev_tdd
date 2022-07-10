import 'package:fordev_tdd/data/usecases/usecases.dart';
import 'package:fordev_tdd/main/factories/http/http.dart';

import '../../../domain/usecases/load_surveys.dart';

class LoadSurveysFactory {
  static LoadSurveys makeRemoteLoadSurveys() => RemoteLoadSurveys(
        httpClient: HttpClientFactory.makeAuthorizeHttpClientDecorator(),
        url: ApiUrlFactory.makeApiUrl('surveys'),
      );
}
