import 'package:medquest/features/setup/year/domain/entity/year_entity.dart';
import 'package:medquest/features/setup/year/domain/repository/year_repository.dart';

class YearUsecase {
  final YearRepository yearRepository;

  const YearUsecase({required this.yearRepository});

  Future<List<YearEntity>> getAllYears() async {
    return await yearRepository.getAllYears();
  }
}
