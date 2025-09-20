import 'package:medquest/features/setup/year/data/model/year_model.dart';
import 'package:medquest/features/setup/year/data/source/year_remote_data_source.dart';
import 'package:medquest/features/setup/year/domain/entity/year_entity.dart';
import 'package:medquest/features/setup/year/domain/repository/year_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class YearRepositoryImpl implements YearRepository {
  final YearRemoteDataSource yearRemoteDataSource;

  const YearRepositoryImpl({required this.yearRemoteDataSource});

  @override
  Future<List<YearEntity>> getAllYears() async {
    final years = await Supabase.instance.client.from("univ_years").select();

    return years
        .map(
          (years) => YearModel.fromJson(
            years,
          ),
        )
        .toList();
  }
}
