import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medquest/features/auth/presentation/Riverpod/auth_providers.dart';
import 'package:medquest/features/auth/presentation/Riverpod/auth_state.dart';
import 'package:medquest/features/auth/presentation/pages/sign_up_page.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifiersProvider);
    ref.listen(authNotifiersProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error.toString())),
        );
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Enter Email";
                  }
                  return null;
                },
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Enter Password";
                  }

                  return null;
                },
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: authState is AuthLoading
                        ? null
                        : () {
                            if (formKey.currentState!.validate()) {
                              ref.read(authNotifiersProvider.notifier).signIn(
                                  emailController.text.trim(),
                                  passwordController.text.trim());
                            }
                          },
                    child: const Text("Sign In"),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => SignUpPage()),
                      );
                    },
                    child: const Text("if u do not have an account \nSign Up"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
