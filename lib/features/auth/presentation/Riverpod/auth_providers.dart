import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medquest/features/auth/data/respository/auth_repository_impl.dart';
import 'package:medquest/features/auth/domain/respository/auth_repository.dart';
import 'package:medquest/features/auth/domain/usecase/auth_use_cases.dart';
import 'package:medquest/features/auth/presentation/Riverpod/auth_notifiers.dart';
import 'package:medquest/features/auth/presentation/Riverpod/auth_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseClientProvider = Provider<SupabaseClient>(
  (ref) {
    return SupabaseClient('https://vkgbusbptbnmmciwkquw.supabase.co',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZrZ2J1c2JwdGJubW1jaXdrcXV3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ0MDU5ODAsImV4cCI6MjA2OTk4MTk4MH0._dzxVENaF_Jtwttlm1WNUV1Jc3s95GvC7_BpCinhmtA');
  },
);
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) {
    final supabase = ref.read(supabaseClientProvider);

    return AuthRepositoryImpl(
      supabase: supabase,
    );
  },
);

final authUseCasesProvider = Provider<AuthUseCases>(
  (ref) {
    final repositoryImpl = ref.read(authRepositoryProvider);

    return AuthUseCases(
      signInUseCase: SignInUseCase(
        authRepository: repositoryImpl,
      ),
      signUpUseCase: SignUpUseCase(
        authRepository: repositoryImpl,
      ),
      signOutUseCase: SignOutUseCase(
        authRepository: repositoryImpl,
      ),
    );
  },
);

final authNotifiersProvider =
    AsyncNotifierProvider<AuthNotifiers, AuthStates>(() {
  return AuthNotifiers();
});
