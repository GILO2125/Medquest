import 'package:medquest/features/mcq/domain/entity/question_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class McqRemoteDataSource {
  Future<List<Map<String, dynamic>>> getQuestions({
    required String courseId,
    required List<int> years,
    required Set<QuestionType> questionTypes,
  });
}

class McqRemoteDataSourceImpl implements McqRemoteDataSource {
  final SupabaseClient client;

  McqRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Map<String, dynamic>>> getQuestions({
    required String courseId,
    required List<int> years,
    required Set<QuestionType> questionTypes,
  }) async {
    final response = await client
        .from("questions")
        .select()
        .eq("course_id", courseId)
        .inFilter("question_type", questionTypes.map((e) => e.name).toList())
        .inFilter("year", years);

    return (response as List).map((e) => e as Map<String, dynamic>).toList();
  }
}
