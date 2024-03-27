import 'package:blog_app/config/theme/theme.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

GlobalKey<ScaffoldMessengerState> snackBarKey = GlobalKey();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            userSignUp: serviceLocator(),
            userLogin: serviceLocator(),
          ),
        )
      ],
      child: MaterialApp(
        scaffoldMessengerKey: snackBarKey,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const SignInPage(),
      ),
    );
  }
}
