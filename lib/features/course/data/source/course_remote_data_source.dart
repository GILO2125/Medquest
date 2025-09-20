import 'package:supabase_flutter/supabase_flutter.dart';

abstract class CourseRemoteDataSource {
  Future<List<Map<String, dynamic>>> getAllCourses({
    required String moduleId,
  });
}

class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  final SupabaseClient client;

  const CourseRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Map<String, dynamic>>> getAllCourses({
    required String moduleId,
  }) async {
    final response = await client.from("courses").select().eq('module_id', moduleId);

    return (response as List).map((e) => e as Map<String, dynamic>).toList();
  }
}
