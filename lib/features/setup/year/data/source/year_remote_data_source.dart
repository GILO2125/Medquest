import 'package:supabase_flutter/supabase_flutter.dart';

abstract class YearRemoteDataSource {
  Future<List<Map<String, dynamic>>> getAllYears();
}

class YearRemoteDataSourceImpl implements YearRemoteDataSource {
  final SupabaseClient client;

  const YearRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Map<String, dynamic>>> getAllYears() async {
    final response = await client.from("univ_years").select();

    return (response as List).map((e) => e as Map<String, dynamic>).toList();
  }
}
