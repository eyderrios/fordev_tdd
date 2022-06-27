import '../../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../http/http.dart';

class AuthenticationFactory {
  static Authentication makeRemoteAuthentication() {
    return RemoteAuthentication(
      httpClient: HttpClientFactory.makeHttpAdapter(),
      url: ApiUrlFactory.makeApiUrl('login'),
    );
  }
}
