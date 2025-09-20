import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ModuleRemoteDataSource {
  Future<List<Map<String, dynamic>>> getAllModules({
    required String yearId,
  });
}

class ModuleRemoteDataSourceImpl implements ModuleRemoteDataSource {
  final SupabaseClient client;
  
  const ModuleRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Map<String, dynamic>>> getAllModules({
    required String yearId,
  }) async {
    final response = await client.from("modules").select().eq('univ_year_id', yearId);

    return (response as List).map((e) => e as Map<String, dynamic>).toList();
  }
}
