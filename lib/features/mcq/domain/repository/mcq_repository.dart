import 'package:medquest/features/mcq/domain/entity/question_entity.dart';

abstract class McqRepository {
  Future<List<QuestionEntity>> getQuestion(
    List<int> years,
    Set<QuestionType> questionType,
    String courseName,
  );
}
