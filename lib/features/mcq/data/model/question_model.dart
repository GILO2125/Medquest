import 'package:medquest/features/mcq/domain/entity/question_entity.dart';

class QuestionModel extends QuestionEntity {
  QuestionModel({
    super.context,
    required super.propostions,
    required super.id,
    required super.questionText,
    required super.questiontype,
    required super.year,
    required super.rotation,
    required super.questionNumber,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> question) {
    return QuestionModel(
      propostions: Map<String, bool>.from(question['propositions']),
      id: question['id'] as String,
      questionText: question['questionText'] as String,
      questiontype: question['questiontype'] == 'clinical'
          ? QuestionType.clinical
          : QuestionType.theoretical ,
      year: question['year'] as int,
      rotation: question['rotation'] as String,
      questionNumber: question['questionNumber'] as int,
      context: question['context'] ?? "" ,
    );
  }
}
