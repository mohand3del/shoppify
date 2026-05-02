import 'package:dio/dio.dart';
import 'package:shoppify/features/auth/data/models/user_model.dart';

abstract class AuthDataSource {
  Future<UserModel> signIn({required String email, required String password});
  Future<UserModel> signUp({required String firstName, required String lastName, required String email, required String password});
}

class AuthDataSourceImpl implements AuthDataSource {
  final Dio dio;
  AuthDataSourceImpl(this.dio);
  @override

  Future<UserModel> signIn({required String email, required String password}) async {
    final response = await dio.post(
      '/api/auth/login',
      data: {'email': email, 'password': password},
    );
    return UserModel.fromJson(response.data);
  }

  @override
  Future<UserModel> signUp({required String firstName, required String lastName, required String email, required String password}) async {
    final response = await dio.post(
      '/api/auth/register',
      data: {'firstName': firstName, 'lastName': lastName, 'email': email, 'password': password},
    );
    return UserModel.fromJson(_extractPayload(response.data));
  }

  Map<String, dynamic> _extractPayload(dynamic raw) {
    if (raw is! Map<String, dynamic>) return <String, dynamic>{};

    final data = raw['data'];
    if (data is Map<String, dynamic>) return data;

    final user = raw['user'];
    if (user is Map<String, dynamic>) return user;

    return raw;
  }
}
