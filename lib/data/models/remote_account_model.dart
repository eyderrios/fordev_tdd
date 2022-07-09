import '../http/http.dart';
import '../../domain/entities/entities.dart';
import '../usecases/authentication/remote_autheticaton.dart';

class RemoteAccountModel {
  final String token;

  RemoteAccountModel(this.token);

  factory RemoteAccountModel.fromJson(RemoteAuthenticationResponse json) {
    if (!json.containsKey('accessToken')) {
      throw HttpError.invalidData;
    }
    return RemoteAccountModel(json['accessToken']);
  }

  AccountEntity toEntity() => AccountEntity(token: token);
}
