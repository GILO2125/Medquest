import 'package:medquest/features/setup/module/data/model/module_model.dart';
import 'package:medquest/features/setup/module/data/source/module_remote_data_source.dart';
import 'package:medquest/features/setup/module/domain/entity/module_entity.dart';
import 'package:medquest/features/setup/module/domain/repository/module_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ModuleRepositoryImpl implements ModuleRepository {
  final ModuleRemoteDataSource moduleRemoteDataSource;

  const ModuleRepositoryImpl({required this.moduleRemoteDataSource});

  @override
  Future<List<ModuleEntity>> getAllModules(String yearId) async {
    final modules = await Supabase.instance.client
        .from("modules")
        .select()
        .eq('univ_year_id', yearId);

    return modules
        .map(
          (modules) => ModuleModel.fromJson(
            modules,
          ),
        )
        .toList();
  }
}
