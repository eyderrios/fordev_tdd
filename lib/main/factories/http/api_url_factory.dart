class ApiUrlFactory {
  static const apiUrl = 'http://fordevs.herokuapp.com/api';

  static String makeApiUrl(String path) => '$apiUrl/$path';
}
