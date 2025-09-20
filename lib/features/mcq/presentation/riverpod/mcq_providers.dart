import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medquest/features/auth/presentation/Riverpod/auth_providers.dart';
import 'package:medquest/features/mcq/data/repository/mcq_repository_impl.dart';
import 'package:medquest/features/mcq/data/source/mcq_remote_data_source.dart';
import 'package:medquest/features/mcq/domain/repository/mcq_repository.dart';
import 'package:medquest/features/mcq/domain/usercases/mcq_usecase.dart';
final mcqRemoteDataSourceProvider = Provider<McqRemoteDataSource>((ref){
   final supabaseClient = ref.read(supabaseClientProvider);
   return McqRemoteDataSourceImpl(client: supabaseClient);
});
final mcqRepositoryProvider = Provider<McqRepository>(
  (ref) {
    final mcqRemoteDataSource = ref.read(mcqRemoteDataSourceProvider);
    return McqRepositoryImpl(mcqRemoteDataSource: mcqRemoteDataSource);
  },
);

final mcqUsecaseProvider = Provider<McqUsecase>(
  (ref) {
    final repository = ref.read(mcqRepositoryProvider);

    return McqUsecase(mcqRepository: repository);
  },
);

