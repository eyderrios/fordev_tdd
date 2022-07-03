import 'package:fordev_tdd/data/models/models.dart';
import 'package:fordev_tdd/domain/entities/account_entity.dart';
import 'package:fordev_tdd/domain/helpers/domain_error.dart';

import '../../../domain/usecases/usecases.dart';
import '../../http/http.dart';

class RemoteAddAccount implements AddAccount {
  final HttpClient httpClient;
  final String url;

  RemoteAddAccount({
    required this.httpClient,
    required this.url,
  });

  @override
  Future<AccountEntity> add(AddAccountParams params) async {
    final body = RemoteAddAccountParams.fromDomain(params).toJson();
    try {
      final response =
          await httpClient.request(url: url, method: 'post', body: body);
      if (response != null) {
        return RemoteAccountModel.fromJson(response).toEntity();
      } else {
        throw HttpError.invalidData;
      }
    } on HttpError catch (error) {
      throw (error == HttpError.forbidden)
          ? DomainError.emailInUse
          : DomainError.unexpected;
    }
  }
}

class RemoteAddAccountParams {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  RemoteAddAccountParams({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  factory RemoteAddAccountParams.fromDomain(AddAccountParams params) =>
      RemoteAddAccountParams(
        name: params.name,
        email: params.email,
        password: params.password,
        passwordConfirmation: params.passwordConfirmation,
      );

  HttpClientBody toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'passwordConfirmation': passwordConfirmation,
      };
}
