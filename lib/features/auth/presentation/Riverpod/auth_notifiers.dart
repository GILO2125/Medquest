import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medquest/features/auth/domain/entity/user_entity.dart';
import 'package:medquest/features/auth/presentation/Riverpod/auth_providers.dart';
import 'package:medquest/features/auth/presentation/Riverpod/auth_state.dart';
import 'package:medquest/main.dart';

class AuthNotifiers extends AsyncNotifier<AuthStates> {
  @override
  Future<AuthStates> build() async {
    final session = supabase.auth.currentSession;
    if (session == null) {
      return UnAuthenticated();
    } else {
      return Authenticated(
        user: UserEntity(
          id: session.user.id,
          email: session.user.email!,
        ),
      );
    }
  }

  Future<void> signOut() async {
    state = const AsyncLoading();

    try {
      await ref.read(authUseCasesProvider).signOutUseCase.signOut();
      state = AsyncData(UnAuthenticated());
    } catch (e) {
      state = AsyncData(
        AuthError(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncLoading();

    try {
      final user = await ref
          .read(authUseCasesProvider)
          .signInUseCase
          .signIn(email, password);

      state = AsyncData(Authenticated(user: user));
    } catch (e) {
      state = AsyncData(
        AuthError(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> signUp(String email, String password) async {
    state = const AsyncLoading();

    try {
      final user = await ref
          .read(authUseCasesProvider)
          .signUpUseCase
          .signUp(email, password);

      state = AsyncData(Authenticated(user: user));
    } catch (e) {
      state = AsyncData(
        AuthError(
          message: e.toString(),
        ),
      );
    }
  }
}
