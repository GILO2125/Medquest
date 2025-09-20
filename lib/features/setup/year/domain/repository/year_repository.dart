import 'package:medquest/features/setup/year/domain/entity/year_entity.dart';

abstract class YearRepository {
  Future<List<YearEntity>> getAllYears();
}
