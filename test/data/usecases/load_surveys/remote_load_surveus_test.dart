import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/data/usecases/load_surveys/load_surveys.dart';

import '../../mocks/mocks.dart';

void main() {
  late HttpClientSpy client;
  late RemoteLoadSurveys sut;
  late String url;

  setUp(() {
    url = faker.internet.httpUrl();
    client = HttpClientSpy();
    sut = RemoteLoadSurveys(url: url, httpClient: client);
  });

  test('Should call HttpClient with correct params', () async {
    // Arrange
    client.mockRequest({});
    // Act
    await sut.load();
    // Assert
    verify(() => client.request(url: url, method: 'get')).called(1);
  });
}
