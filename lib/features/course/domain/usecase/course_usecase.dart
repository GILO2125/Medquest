import 'package:medquest/features/course/domain/entity/course_entity.dart';
import 'package:medquest/features/course/domain/repository/course_repository.dart';

class CourseUsecase {
  final CourseRepository courseRepository;

  const CourseUsecase({required this.courseRepository});

  Future<List<CourseEntity>> getAllCourses(String moduleId) async {
    return await courseRepository.getAllCourses(moduleId);
  }
}
