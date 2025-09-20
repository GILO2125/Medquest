import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medquest/features/auth/presentation/Riverpod/auth_providers.dart';
import 'package:medquest/features/auth/presentation/Riverpod/auth_state.dart';
import 'package:medquest/features/auth/presentation/pages/authenticated_page.dart';
import 'package:medquest/features/auth/presentation/pages/sign_in_page.dart';
import 'package:medquest/features/setup/presentation/screens/setup_page.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(authNotifiersProvider);

    return notifier.when(
      data: (state) {
        if (state is Authenticated) {
          return const SetupPage();
        } else if (state is UnAuthenticated) {
          return  SignInPage();
        } else if (state is AuthError) {
          return Scaffold(
            body: Center(
              child: Text("Auth Error: ${state.message}"),
            ),
          );
        }
        return const SizedBox(); // fallback
      },
      error: (e, st) {
        return Scaffold(
          body: Center(
            child: Text("Error: $e"),
          ),
        );
      },
      loading: () {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
