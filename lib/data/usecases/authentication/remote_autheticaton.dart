import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../http/http.dart';
import '../../models/models.dart';

typedef RemoteAuthenticationResponse = Map<String, dynamic>;

class RemoteAuthentication implements Authentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({
    required this.httpClient,
    required this.url,
  });

  @override
  Future<AccountEntity> auth(AuthenticationParams params) async {
    try {
      final response = await httpClient.request(
        url: url,
        method: 'post',
        body: RemoteAuthenticationParams.fromDomain(params).toJson(),
      );
      if (response != null) {
        return RemoteAccountModel.fromJson(response).toEntity();
      } else {
        throw HttpError.invalidData;
      }
    } on HttpError catch (error) {
      throw (error == HttpError.unauthorized)
          ? DomainError.invalidCredentials
          : DomainError.unexpected;
    }
  }
}

class RemoteAuthenticationParams {
  final String email;
  final String password;

  RemoteAuthenticationParams({
    required this.email,
    required this.password,
  });

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams params) =>
      RemoteAuthenticationParams(
        email: params.email,
        password: params.password,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}
