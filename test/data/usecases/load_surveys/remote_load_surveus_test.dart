import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/data/usecases/load_surveys/load_surveys.dart';

import '../../mocks/mocks.dart';

void main() {
  test('Should call HttpClient with correct params', () async {
    // Arrange
    final url = faker.internet.httpUrl();
    final client = HttpClientSpy();
    final sut = RemoteLoadSurveys(url: url, httpClient: client);
    client.mockRequest({});
    // Act
    await sut.load();
    // Assert
    verify(() => client.request(url: url, method: 'get')).called(1);
  });
}
