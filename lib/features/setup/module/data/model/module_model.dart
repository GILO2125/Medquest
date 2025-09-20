import 'package:medquest/features/setup/module/domain/entity/module_entity.dart';

class ModuleModel extends ModuleEntity {
  const ModuleModel({required super.name, required super.id});

  factory ModuleModel.fromJson(Map<String, dynamic> modules) {
    return ModuleModel(
        name: modules["name"] as String, id: modules["id"] as String);
  }
}
