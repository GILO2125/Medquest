import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medquest/features/setup/presentation/riverpod/setup_providers.dart';
import 'package:medquest/features/setup/presentation/riverpod/setup_state.dart';

class SetupNotifiers extends AsyncNotifier<SetupState> {
  @override
  FutureOr<SetupState> build() async {
    final yearUsecase = ref.read(yearUsecaseProvider);
    final years = await yearUsecase.getAllYears();

    return SetupState.initial().copyWith(
      years: YearState(years: years),
    );
  }

  Future<void> getModules(String yearId) async {
    state = const AsyncLoading();
    try {
      final modelUsecase = ref.read(moduleUsecaseProvider);

      final modules = await modelUsecase.getAllModules(yearId);
      final currentState = state.value ?? SetupState.initial();

      state = AsyncData(
        currentState.copyWith(
          modules: ModuleState(modules: modules),
        ),
      );
    } catch (e, st) {
      state = AsyncError(e.toString(), st);
    }
  }
}
