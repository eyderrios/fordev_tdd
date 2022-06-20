import '../../domain/entities/account_entity.dart';
import '../http/http.dart';

class RemoteAccountModel {
  final String token;

  RemoteAccountModel(this.token);

  factory RemoteAccountModel.fromJson(HttpClientBody json) {
    if (!json.containsKey('accessToken')) {
      throw HttpError.invalidData;
    }
    return RemoteAccountModel(json['accessToken']);
  }

  AccountEntity toEntity() => AccountEntity(token: token);
}
