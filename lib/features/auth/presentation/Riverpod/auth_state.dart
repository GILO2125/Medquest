import 'package:medquest/features/auth/domain/entity/user_entity.dart';

sealed class AuthStates {}

class Authenticated  extends AuthStates {
  final UserEntity user;

  Authenticated ({required this.user});
}

class UnAuthenticated extends AuthStates {
  
}

class AuthError extends AuthStates {
  final String message;

  AuthError({required this.message});
}

class AuthLoading extends AuthStates {}
