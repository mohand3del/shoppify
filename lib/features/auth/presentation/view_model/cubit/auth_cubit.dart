import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shoppify/features/auth/domain/entitiy/user_entity.dart';
import 'package:shoppify/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:shoppify/features/auth/domain/usecases/sign_up_use_case.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.signInUseCase, required this.signUpUseCase})
    : super(AuthInitial());
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthLoading());
    final (user, failure) = await signInUseCase.signIn(email: email, password: password);
   if(failure != null) {
     emit(AuthFailure(failure.toString()));
   } else if(user != null) {
     emit(AuthSuccess(user));
   } else {
     emit( AuthFailure('Unknown error occurred'));
   }
  }

  Future<void> signUp({required String firstName, required String lastName, required String email, required String password}) async {
    emit(AuthLoading());
    final (user, failure) = await signUpUseCase.signUp(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );
    if(failure != null) {
      emit(AuthFailure(failure.toString()));
    } else if(user != null) {
      emit(AuthSuccess(user));
    } else {
      emit( AuthFailure('Unknown error occurred'));
    }
  }
}
