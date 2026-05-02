


import 'package:shoppify/features/auth/data/models/user_model.dart';
import 'package:shoppify/features/auth/domain/entitiy/user_entity.dart';

class UserMapper {



  static UserEntity toEntity(UserModel model) {
    return UserEntity(
      id: model.id,
      firstName: model.firstName,
      lastName: model.lastName,
      email: model.email,
      token: model.token,
      refreshToken: model.refreshToken,
      expiresAtUtc: model.expiresAtUtc,
    );
  }
}