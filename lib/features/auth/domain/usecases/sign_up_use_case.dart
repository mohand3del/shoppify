

import 'package:shoppify/core/error/failures.dart';
import 'package:shoppify/features/auth/domain/entitiy/user_entity.dart';
import 'package:shoppify/features/auth/domain/repo/auth_repo.dart';

class SignUpUseCase {
  AuthRepo repository;
  SignUpUseCase(this.repository);

  Future<(UserEntity?, Failure?)> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    return await repository.signUp(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );
  }
}