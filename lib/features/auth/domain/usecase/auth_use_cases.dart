import 'package:medquest/features/auth/domain/entity/user_entity.dart';
import 'package:medquest/features/auth/domain/respository/auth_repository.dart';

class AuthUseCases {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;
  AuthUseCases({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
  });
}

class SignUpUseCase {
  final AuthRepository authRepository;
  SignUpUseCase({required this.authRepository});

  Future<UserEntity> signUp(String email, String password) async {
    return await authRepository.signUp(email, password);
  }
}

class SignInUseCase {
  final AuthRepository authRepository;
  SignInUseCase({required this.authRepository});

  Future<UserEntity> signIn(String email, String password) async {
    return await authRepository.signIn(email, password);
  }
}

class SignOutUseCase {
  final AuthRepository authRepository;

  SignOutUseCase({required this.authRepository});

  Future<void> signOut() async {
    return await authRepository.signOut();
  }
}
