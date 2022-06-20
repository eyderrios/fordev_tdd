import 'package:faker/faker.dart';

class ApiFactory {
  static Map<String, dynamic> makeAccountBody() => {
        'accessToken': faker.guid.guid(),
        'name': faker.person.name(),
      };

  static Map<String, dynamic> makeEmptyBody() => {};

  static Map<String, dynamic> makeValidBody() => {
        'some_key': 'some_data',
      };

  static Map<String, dynamic> makeInvalidBody() => {
        'invalid_key': 'invalid_data',
      };
}
