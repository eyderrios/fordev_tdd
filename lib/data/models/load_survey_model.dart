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

  factory LocalSurveyModel.fromMap(Map json) {
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

  factory LocalSurveyModel.fromEntity(SurveyEntity entity) {
    return LocalSurveyModel(
      id: entity.id,
      question: entity.question,
      date: entity.dateTime,
      didAnswer: entity.didAnswer,
    );
  }

  SurveyEntity toEntity() => SurveyEntity(
      id: id, question: question, dateTime: date, didAnswer: didAnswer);

  Map<String, String> toMap() => {
        'id': id,
        'question': question,
        'date': date.toIso8601String(),
        'didAnswer': didAnswer.toString(),
      };
}
