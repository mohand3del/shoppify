part of 'auth_cubit.dart';

@immutable
sealed class AuthState extends Equatable {
  @override
  List<Object?> get props => [];

}

final class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}
final class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
  }
final class AuthSuccess extends AuthState {
  final UserEntity user;
  AuthSuccess(this.user);
  @override
  List<Object?> get props => [user];
}
final class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
  @override
  List<Object?> get props => [message];
}
