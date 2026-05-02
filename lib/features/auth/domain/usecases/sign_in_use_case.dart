


import 'package:shoppify/core/error/failures.dart';
import 'package:shoppify/features/auth/domain/entitiy/user_entity.dart';
import 'package:shoppify/features/auth/domain/repo/auth_repo.dart';

class SignInUseCase {

  final AuthRepo repository;
  SignInUseCase(this.repository);

  Future<(UserEntity?, Failure?)> signIn({
    required String email,
    required String password,
  }) async {
    return await repository.signIn(email: email, password: password);
  }
}