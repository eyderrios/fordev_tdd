import 'package:faker/faker.dart';

class ApiFactory {
  static Map<String, dynamic> makeAccountBody() => {
        'accessToken': faker.guid.guid(),
        'name': faker.person.name(),
      };

  static Map<String, dynamic> makeEmptyBody() => {};

  static Map<String, dynamic> makeInvalidBody() => {
        'invalid_key1': 'invalid_data1',
        'invalid_key2': 'invalid_data2',
        'invalid_key3': 'invalid_data3',
      };
}
