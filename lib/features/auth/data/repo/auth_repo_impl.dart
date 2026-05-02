import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppify/core/error/failures.dart';
import 'package:shoppify/features/auth/data/data_source/auth_data_source.dart';
import 'package:shoppify/features/auth/data/mapper/user_mpper.dart';
import 'package:shoppify/features/auth/domain/entitiy/user_entity.dart';
import 'package:shoppify/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthDataSource dataSource;
  AuthRepoImpl(this.dataSource);
 

    Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Failure _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure(
          'Connection timed out. Check your internet.',
        );
      case DioExceptionType.connectionError:
        return const NetworkFailure('No internet connection.');
      default:
        final statusCode = e.response?.statusCode;
        final message = _extractErrorMessage(e.response?.data, e.message);

        if (statusCode == 401) return UnauthorizedFailure(message);
        if (statusCode == 400 || statusCode == 422)
          return ValidationFailure(message);
        return ServerFailure(message);
    }
  }
   String _extractErrorMessage(dynamic data, String? fallback) {
    if (data is Map<String, dynamic>) {
      final errors = data['errors'];
      if (errors is Map<String, dynamic> && errors.isNotEmpty) {
        final parts = <String>[];
        errors.forEach((field, value) {
          if (value is List) {
            for (final item in value) {
              final text = item?.toString().trim();
              if (text != null && text.isNotEmpty) {
                parts.add('$field: $text');
              }
            }
          }
        });
        if (parts.isNotEmpty) return parts.join('\n');
      }

      final message = data['message']?.toString().trim();
      if (message != null && message.isNotEmpty) return message;
    }

    return fallback ?? 'Something went wrong';
  }
  
  @override
  Future<(UserEntity?, Failure?)> signIn({required String email, required String password}) async { try {
      final model = await dataSource.signIn(
        email: email,
        password: password,
      );

      // Save token locally
      await _saveToken(model.token);

      return (UserMapper.toEntity(model), null);
    } on DioException catch (e) {
      return (null, _handleDioError(e));
    } catch (e) {
      return (null, ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<(UserEntity?, Failure?)> signUp({required String firstName, required String lastName, required String email, required String password}) async {
    try {
      final model = await dataSource.signUp(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );

      // Save token locally
      await _saveToken(model.token);

      return (UserMapper.toEntity(model), null);
    } on DioException catch (e) {
      return (null, _handleDioError(e));
    } catch (e) {
      return (null, ServerFailure(e.toString()));
    }
  }

}
