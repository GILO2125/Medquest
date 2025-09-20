import 'package:medquest/features/course/domain/entity/course_entity.dart';

abstract class CourseRepository {
  Future<List<CourseEntity>> getAllCourses(
    String moduleId,
  );
}
