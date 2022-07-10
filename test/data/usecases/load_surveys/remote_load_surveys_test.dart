import 'package:faker/faker.dart';
import 'package:fordev_tdd/data/models/models.dart';
import 'package:fordev_tdd/domain/helpers/domain_error.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev_tdd/domain/entities/entities.dart';
import 'package:fordev_tdd/data/http/http.dart';
import 'package:fordev_tdd/data/usecases/load_surveys/load_surveys.dart';

import '../../mocks/mocks.dart';

void main() {
  const dataCount = 2;
  late HttpClientSpy client;
  late RemoteLoadSurveys sut;
  late String url;
  late RemoteLoadSurveysResponse validData;
  late RemoteLoadSurveysResponse invalidData;

  RemoteLoadSurveysResponse mockValidData(int count) =>
      RemoteLoadSurveysResponse.generate(
          count,
          (_) => {
                'id': faker.guid.guid(),
                'question': faker.randomGenerator.string(50),
                'didAnswer': faker.randomGenerator.boolean(),
                'date': faker.date.dateTime().toIso8601String(),
              });

  List<SurveyEntity> remoteDataToEntityList(RemoteLoadSurveysResponse list) =>
      List<SurveyEntity>.generate(
        list.length,
        (index) => RemoteSurveyModel.fromJson(list[index]).toEntity(),
      );

  setUp(() {
    url = faker.internet.httpUrl();
    client = HttpClientSpy();
    sut = RemoteLoadSurveys(url: url, httpClient: client);
    validData = mockValidData(dataCount);
    invalidData = [
      {'invalid_key': 'invalid_value'}
    ];
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

  test(
      'Should throw UnexpectedError if HttpClient returns 200 with invalid data',
      () async {
    // Arrange
    client.mockRequest(invalidData);
    // Act
    final future = sut.load();
    // Assert
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    // Arrange
    client.mockRequest(validData);
    client.mockRequestError(HttpError.notFound);
    // Act
    final future = sut.load();
    // Assert
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    // Arrange
    client.mockRequest(validData);
    client.mockRequestError(HttpError.serverError);
    // Act
    final future = sut.load();
    // Assert
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw AccessDeniedError if HttpClient returns 403', () async {
    // Arrange
    client.mockRequest(validData);
    client.mockRequestError(HttpError.forbidden);
    // Act
    final future = sut.load();
    // Assert
    expect(future, throwsA(DomainError.accessDenied));
  });
}
