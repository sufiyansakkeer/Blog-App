import 'dart:developer';

import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blog_app/config/theme/app_palette.dart';
import 'package:blog_app/core/extension/gap_extension.dart';
import 'package:blog_app/core/extension/navigation_extension.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_fields.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              state.message.showSnack();
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  30.height(),
                  AuthField(
                    hintText: 'Email',
                    textEditingController: emailController,
                    validator: (value) {
                      if (value == null) {
                        return "Required";
                      }
                      if (value.isEmpty) {
                        return "Required";
                      }
                      if (!RegExp(
                              r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+)(\.[a-zA-Z0-9-]+)*(\.[a-z]{2,})$')
                          .hasMatch(value)) {
                        return "Please enter valid email";
                      }
                      return null;
                    },
                  ),
                  15.height(),
                  AuthField(
                    hintText: 'Password',
                    textEditingController: passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password cannot be empty";
                      }
                      return null;
                    },
                  ),
                  15.height(),
                  AuthGradientButton(
                    onPressed: () {
                      log(
                        formKey.currentState!.validate().toString(),
                        name: "sign in page validator",
                      );

                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              AuthLogin(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            );
                      }
                    },
                    text: 'Sign In',
                  ),
                  15.height(),
                  GestureDetector(
                    onTap: () => context.pushReplacement(const SignUpPage()),
                    child: RichText(
                        text: TextSpan(
                      text: "Don't have an account? ",
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [
                        TextSpan(
                          text: "Sign Up",
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: AppPalette.gradient1,
                                  ),
                        ),
                      ],
                    )),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
