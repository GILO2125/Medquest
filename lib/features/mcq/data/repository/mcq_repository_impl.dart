import 'package:medquest/features/mcq/data/model/question_model.dart';
import 'package:medquest/features/mcq/data/source/mcq_remote_data_source.dart';
import 'package:medquest/features/mcq/domain/entity/question_entity.dart';
import 'package:medquest/features/mcq/domain/repository/mcq_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class McqRepositoryImpl implements McqRepository {
  final McqRemoteDataSource mcqRemoteDataSource;

  McqRepositoryImpl({required this.mcqRemoteDataSource});

  @override
  Future<List<QuestionEntity>> getQuestion(List<int> years,
      Set<QuestionType> questionType, String courseName) async {
    final questions = await Supabase.instance.client
        .from("questions")
        .select()
        .eq("course_Id", courseName)
        .inFilter("type", questionType.map((e) => e.name).toList())
        .inFilter("year", years);

    return questions
        .map(
          (question) => QuestionModel.fromJson(
            question,
          ),
        )
        .toList();
  }
}
