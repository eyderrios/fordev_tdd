import 'package:faker/faker.dart';
import 'package:fordev_tdd/data/models/models.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/domain/entities/entities.dart';
import 'package:fordev_tdd/data/http/http.dart';
import 'package:fordev_tdd/data/usecases/load_surveys/load_surveys.dart';

import '../../mocks/mocks.dart';

void main() {
  const dataCount = 2;
  late HttpClientSpy<List<HttpClientBody>> client;
  late RemoteLoadSurveys sut;
  late String url;
  late List<HttpClientBody> validData;

  List<HttpClientBody> mockValidData(int count) =>
      List<HttpClientBody>.generate(
          count,
          (_) => {
                'id': faker.guid.guid(),
                'question': faker.randomGenerator.string(50),
                'didAnswer': faker.randomGenerator.boolean(),
                'date': faker.date.dateTime().toIso8601String(),
              });

  List<SurveyEntity> remoteDataToEntityList(List<HttpClientBody> list) =>
      List<SurveyEntity>.generate(
        list.length,
        (index) => RemoteSurveyModel.fromJson(list[index]).toEntity(),
      );

  setUp(() {
    url = faker.internet.httpUrl();
    client = HttpClientSpy<List<HttpClientBody>>();
    sut = RemoteLoadSurveys(url: url, httpClient: client);
    validData = mockValidData(dataCount);
  });

  test('Should call HttpClient with correct params', () async {
    // Arrange
    client.mockRequest(validData);
    // Act
    await sut.load();
    // Assert
    verify(() => client.request(url: url, method: 'get')).called(1);
  });

  test('Should return surveys on 200', () async {
    // Arrange
    client.mockRequest(validData);
    final expectedData = remoteDataToEntityList(validData);
    // Act
    final surveys = await sut.load();
    // Assert
    expect(surveys, expectedData);
  });
}
