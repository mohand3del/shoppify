

import 'package:shoppify/core/error/failures.dart';
import 'package:shoppify/features/auth/domain/entitiy/user_entity.dart';

abstract class AuthRepo  {

  Future<(UserEntity?, Failure?)> signIn({
    required String email,
    required String password,
  });

  Future<(UserEntity?, Failure?)> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });



}
