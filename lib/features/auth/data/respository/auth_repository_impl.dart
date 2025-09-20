import 'package:medquest/features/auth/domain/entity/user_entity.dart';
import 'package:medquest/features/auth/data/model/user_model.dart';
import 'package:medquest/features/auth/domain/respository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.supabase});
  SupabaseClient supabase;

  @override
  Future<UserEntity> signIn(String email, String password) async {
    final client = await supabase.auth
        .signInWithPassword(password: password, email: email);
    final user = client.user;
    if (user == null) {
      throw Exception('Sign in failed');
    }

    return UserModel.fromJson(user);
  }

  @override
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  @override
  Future<UserEntity> signUp(String email, String password) async {
    final client = await supabase.auth
        .signUp(password: password, email: email,);
    final user = client.user;
    if (user == null) {
      throw Exception('Sign up failed');
    }

    return UserModel.fromJson(user);
  }
}
