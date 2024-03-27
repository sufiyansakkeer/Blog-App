import 'dart:developer';

import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/features/auth/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSources {
  Session? get currentUserSession;
  Future<UserModel> signUpWithEmailPassword({
    required String email,
    required String name,
    required String password,
  });
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourcesImp implements AuthRemoteDataSources {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourcesImp({
    required this.supabaseClient,
  });

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      debugPrint(
        response.toString(),
      );
      if (response.user == null) {
        throw ServerException("User is null");
      }
      return UserModel.fromJson(
        response.user!.toJson(),
      ).copyWith(email: email);
    } catch (e) {
      debugPrint(
        e.toString(),
      );
      log(e.toString(), name: "sign in supabase Exception");
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth
          .signUp(password: password, email: email, data: {"name": name});
      debugPrint(
        response.toString(),
      );
      if (response.user == null) {
        throw ServerException("User is null");
      }
      return UserModel.fromJson(
        response.user!.toJson(),
      ).copyWith(email: email);
    } catch (e) {
      debugPrint(
        e.toString(),
      );
      log(e.toString(), name: "sign up supabase Exception");
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from("profiles")
            .select()
            .eq("id", currentUserSession!.user.id);
        return UserModel.fromJson(
          userData.first,
        ).copyWith(
          email: currentUserSession!.user.email,
        );
      }
      return null;
    } catch (e) {
      log(e.toString(), name: "get current user data exception");
      throw ServerException(e.toString());
    }
  }
}
