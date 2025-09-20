import 'package:medquest/features/course/domain/entity/course_entity.dart';

class CourseModel extends CourseEntity {
  const CourseModel({required super.name, required super.id});

  factory CourseModel.fromJson(Map<String, dynamic> course) {
    return CourseModel(
        name: course["name"] as String, id: course["id"] as String);
  }
}
