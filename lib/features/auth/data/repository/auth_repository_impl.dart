import 'dart:developer';

import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/data/data_sources/auth_remote_data_sources.dart';
import 'package:blog_app/core/common/entity/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSources authRemoteDataSources;

  AuthRepositoryImpl(this.authRemoteDataSources);

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final user = await authRemoteDataSources.getCurrentUserData();
      if (user != null) {
        log(user.id, name: "user id in auth rep impl");
        return right(user);
      }
      return left(Failure("User not logged in"));
    } on ServerException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await authRemoteDataSources.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
        () async => await authRemoteDataSources.signUpWithEmailPassword(
              email: email,
              name: name,
              password: password,
            ));
  }

  Future<Either<Failure, User>> _getUser(
      Future<User> Function() function) async {
    try {
      final user = await function();
      return right(user);
    } on sb.AuthException catch (e) {
      return left(
        Failure(e.message),
      );
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
