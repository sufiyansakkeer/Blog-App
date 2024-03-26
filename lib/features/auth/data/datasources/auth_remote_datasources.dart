import 'dart:developer';

import 'package:blog_app/core/error/exception.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSources {
  Future<String> signUpWithEmailPassword({
    required String email,
    required String name,
    required String password,
  });
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourcesImp implements AuthRemoteDataSources {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourcesImp({
    required this.supabaseClient,
  });
  @override
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailPassword({
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
      return response.user!.id;
    } catch (e) {
      debugPrint(
        e.toString(),
      );
      log(e.toString(), name: "sign up supabase Exception");
      throw ServerException(e.toString());
    }
  }
}
