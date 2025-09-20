import 'package:medquest/features/mcq/domain/entity/question_entity.dart';
import 'package:medquest/features/mcq/domain/repository/mcq_repository.dart';

class McqUsecase {
  final McqRepository mcqRepository;

  McqUsecase({required this.mcqRepository});

  Future<List<QuestionEntity>> getQuestions(
    Set<QuestionType> questionType,
    String courseName,
    List<int> years,
  ) async {
    return await mcqRepository.getQuestion(
      years,
      questionType,
      courseName,
    );
  }
}


