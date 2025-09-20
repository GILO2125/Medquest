import 'package:medquest/features/setup/module/domain/entity/module_entity.dart';
import 'package:medquest/features/setup/year/domain/entity/year_entity.dart';

class SetupState {
  final ModuleState modules;
  final YearState years;

  const SetupState({
    required this.years,
    required this.modules,
  });

  factory SetupState.initial() => SetupState(
        years: YearState.initial(),
        modules: ModuleState.initial(),
      );


  SetupState copyWith({
    YearState? years, 
    ModuleState? modules
    }){
      return SetupState(
        years: years ?? this.years,
        modules: modules ?? this.modules,
      );}
}

class ModuleState {
  final List<ModuleEntity> modules;

  const ModuleState({required this.modules});

  factory ModuleState.initial() => ModuleState(
        modules: [],
      );
}

class YearState {
  final List<YearEntity> years;

  const YearState({
    required this.years,
  });

  factory YearState.initial() => YearState(
        years: [],
      );
}
