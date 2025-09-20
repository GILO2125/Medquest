import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medquest/features/auth/presentation/Riverpod/auth_providers.dart';
import 'package:medquest/features/auth/presentation/Riverpod/auth_state.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SignUpPageConsumerState();
}

class _SignUpPageConsumerState extends ConsumerState<SignUpPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authNotifiersProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error.toString())),
        );
      }
    });
    final authState = ref.watch(authNotifiersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUnfocus,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Entrez votre email";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Entrez votre mot de pass";
                  }
                  return null;
                },
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Mot de pass",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: authState is AuthLoading
                    ? null
                    : () {
                        if (formKey.currentState!.validate()) {
                          ref.read(authNotifiersProvider.notifier).signUp(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );
                        }
                      },
                child: authState is AuthLoading
                    ? SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ))
                    : const Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
