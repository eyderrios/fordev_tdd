import '../../domain/entities/entities.dart';

class LocalSurveyModel {
  final String id;
  final String question;
  final DateTime date;
  final bool didAnswer;

  LocalSurveyModel({
    required this.id,
    required this.question,
    required this.date,
    required this.didAnswer,
  });

  static List<String> get fields => ['id', 'question', 'date', 'didAnswer'];

  factory LocalSurveyModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(fields)) {
      throw Exception();
    }
    return LocalSurveyModel(
      id: json['id'],
      question: json['question'],
      date: DateTime.parse(json['date']),
      didAnswer: bool.fromEnvironment(json['didAnswer']),
    );
  }

  SurveyEntity toEntity() => SurveyEntity(
      id: id, question: question, dateTime: date, didAnswer: didAnswer);
}
