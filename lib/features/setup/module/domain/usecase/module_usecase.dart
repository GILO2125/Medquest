import 'package:medquest/features/setup/module/domain/entity/module_entity.dart';
import 'package:medquest/features/setup/module/domain/repository/module_repository.dart';

class ModuleUsecase {
  final ModuleRepository moduleRepository;

  const ModuleUsecase({required this.moduleRepository});

  Future<List<ModuleEntity>> getAllModules(String yearId) async {
    return await moduleRepository.getAllModules(yearId);
  }
}
