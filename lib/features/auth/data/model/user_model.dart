import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:medquest/features/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.email, required super.id});

  factory UserModel.fromJson(User user) {
    return UserModel(
      id: user.id,
      email: user.email!,
    );
  }


}
