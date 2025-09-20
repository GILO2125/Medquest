import 'package:medquest/features/setup/module/domain/entity/module_entity.dart';

abstract class ModuleRepository {
  Future<List<ModuleEntity>> getAllModules(
    String yearId,
  );
}
