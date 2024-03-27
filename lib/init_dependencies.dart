import 'package:blog_app/core/secrets/app_secretes.dart';
import 'package:blog_app/features/auth/data/data_sources/auth_remote_data_sources.dart';
import 'package:blog_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up_usecase.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

GetIt serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.anonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  // here we added AuthRemoteDataSource as the generic form of the register
  // factory , because when we try to register for auth repository it can't find
  // AuthRemoteDataSource only AuthRemoteDataSourceImpl and that's why.

  serviceLocator
    // Data source
    ..registerFactory<AuthRemoteDataSources>(
      () => AuthRemoteDataSourcesImp(
        supabaseClient: serviceLocator(),
      ),
    )
    //Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )
    // usecases
    ..registerFactory(
      () => UserSignUpUseCase(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLoginUseCase(
        authRepository: serviceLocator(),
      ),
    )
    // bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
      ),
    );
}
