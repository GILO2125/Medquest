import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medquest/features/auth/presentation/Riverpod/auth_providers.dart';
import 'package:medquest/features/setup/module/data/repository/module_repository_impl.dart';
import 'package:medquest/features/setup/module/data/source/module_remote_data_source.dart';
import 'package:medquest/features/setup/module/domain/repository/module_repository.dart';
import 'package:medquest/features/setup/module/domain/usecase/module_usecase.dart';
import 'package:medquest/features/setup/presentation/riverpod/setup_notifiers.dart';
import 'package:medquest/features/setup/presentation/riverpod/setup_state.dart';
import 'package:medquest/features/setup/year/data/repository/year_repository_impl.dart';
import 'package:medquest/features/setup/year/data/source/year_remote_data_source.dart';
import 'package:medquest/features/setup/year/domain/repository/year_repository.dart';
import 'package:medquest/features/setup/year/domain/usecase/module_usecase.dart';

final moduleRemoteDataSourceProvider = Provider<ModuleRemoteDataSource>((ref) {
  final supabaseClient = ref.read(supabaseClientProvider);

  return ModuleRemoteDataSourceImpl(client: supabaseClient);
});
final moduleRepositoryProvider = Provider<ModuleRepository>(
  (ref) {
    final remoteDataSource = ref.read(moduleRemoteDataSourceProvider);

    return ModuleRepositoryImpl(
      moduleRemoteDataSource: remoteDataSource,
    );
  },
);

final moduleUsecaseProvider = Provider<ModuleUsecase>(
  (ref) {
    final repositoryImpl = ref.read(moduleRepositoryProvider);

    return ModuleUsecase(
      moduleRepository: repositoryImpl,
    );
  },
);

final yearRemoteDataSourceProvider = Provider<YearRemoteDataSource>((ref) {
  final supabaseClient = ref.read(supabaseClientProvider);

  return YearRemoteDataSourceImpl(client: supabaseClient);
});
final yearRepositoryProvider = Provider<YearRepository>(
  (ref) {
    final remoteDataSource = ref.read(yearRemoteDataSourceProvider);

    return YearRepositoryImpl(yearRemoteDataSource: remoteDataSource);
  },
);

final yearUsecaseProvider = Provider<YearUsecase>(
  (ref) {
    final repositoryImpl = ref.read(yearRepositoryProvider);

    return YearUsecase(yearRepository: repositoryImpl);
  },
);


final setupNotifiersProvider =
    AsyncNotifierProvider<SetupNotifiers, SetupState>(() {
  final setupNotifiers = SetupNotifiers();
  return setupNotifiers;
});


