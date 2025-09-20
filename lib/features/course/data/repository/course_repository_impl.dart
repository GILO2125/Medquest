import 'package:medquest/features/course/data/model/course_model.dart';
import 'package:medquest/features/course/data/source/course_remote_data_source.dart';
import 'package:medquest/features/course/domain/entity/course_entity.dart';
import 'package:medquest/features/course/domain/repository/course_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CourseRepositoryImpl implements CourseRepository {
  final CourseRemoteDataSource courseRemoteDataSource;

  const CourseRepositoryImpl({required this.courseRemoteDataSource});

  @override
  Future<List<CourseEntity>> getAllCourses(String moduleId) async {
    final courses = await Supabase.instance.client.from("courses").select().eq('module_id', moduleId);

    return courses
        .map(
          (courses) => CourseModel.fromJson(
            courses,
          ),
        )
        .toList();
  }
}
