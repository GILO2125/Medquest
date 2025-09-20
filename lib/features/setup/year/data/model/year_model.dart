import 'package:medquest/features/setup/year/domain/entity/year_entity.dart';

class YearModel extends YearEntity {
  const YearModel({required super.name, required super.id});

  factory YearModel.fromJson(Map<String, dynamic> years) {
    return YearModel(
        name: years["name"] as String, id: years["id"] as String);
  }
}
