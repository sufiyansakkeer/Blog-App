import 'package:blog_app/features/auth/domain/usecases/user_sign_up_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpUseCase _userSignUp;
  AuthBloc({required UserSignUpUseCase userSignUp})
      : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      final response = await _userSignUp(UserSignUpParams(
        email: event.email,
        name: event.name,
        password: event.password,
      ));
      response.fold(
        (l) => emit(AuthFailure(message: l.errorMsg)),
        (r) => emit(AuthSuccess(uid: r)),
      );
    });
  }
}
