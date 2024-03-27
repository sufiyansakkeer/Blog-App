import 'package:blog_app/features/auth/domain/entity/user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpUseCase _userSignUp;
  final UserLoginUseCase _userLogin;
  AuthBloc(
      {required UserSignUpUseCase userSignUp,
      required UserLoginUseCase userLogin})
      : _userSignUp = userSignUp,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);

    on<AuthLogin>(_onAuthLogin);
  }

// Auth sign up function
  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        name: event.name,
        password: event.password,
      ),
    );
    response.fold(
      (l) => emit(
        AuthFailure(message: l.errorMsg),
      ),
      (r) => emit(
        AuthSuccess(user: r),
      ),
    );
  }

//Auth login Function
  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userLogin(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );
    response.fold(
      (l) => emit(
        AuthFailure(message: l.errorMsg),
      ),
      (r) => emit(
        AuthSuccess(user: r),
      ),
    );
  }
}
