import '../../domain/entities/entities.dart';
import '../http/http.dart';

class RemoteSurveyModel {
  final String id;
  final String question;
  final String date;
  final bool didAnswer;

  RemoteSurveyModel({
    required this.id,
    required this.question,
    required this.date,
    required this.didAnswer,
  });

  static List<String> get fields => ['id', 'question', 'date', 'didAnswer'];

  factory RemoteSurveyModel.fromJson(HttpClientBody json) {
    if (!json.keys.toSet().containsAll(fields)) {
      throw HttpError.invalidData;
    }
    return RemoteSurveyModel(
      id: json['id'],
      question: json['question'],
      date: json['date'],
      didAnswer: json['didAnswer'],
    );
  }

  SurveyEntity toEntity() => SurveyEntity(
      id: id,
      question: question,
      dateTime: DateTime.parse(date),
      didAnswer: didAnswer);
}
