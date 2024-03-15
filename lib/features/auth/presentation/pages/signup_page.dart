import 'dart:developer';

import 'package:blog_app/config/theme/app_palette.dart';
import 'package:blog_app/core/extension/gap_extension.dart';
import 'package:blog_app/core/extension/navigation_extension.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_fields.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
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
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              30.height(),
              AuthField(
                hintText: 'Name',
                textEditingController: nameController,
                validator: (value) {
                  if (value == null) {
                    return "required";
                  }
                  if (value.isEmpty) {
                    return "Required";
                  }
                  return null;
                },
              ),
              15.height(),
              AuthField(
                hintText: 'Email',
                textEditingController: emailController,
                keyboardType: TextInputType.emailAddress,
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
                  } else if (value.length < 6) {
                    return "Password must be at least 6 characters long";
                  } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
                    return "Password must contain at least one uppercase letter";
                  } else if (!RegExp(r'[a-z]').hasMatch(value)) {
                    return "Password must contain at least one lowercase letter";
                  } else if (!RegExp(r'[0-9]').hasMatch(value)) {
                    return "Password must contain at least one digit";
                  } else if (!RegExp(r'[!@#\$&*_-]').hasMatch(value)) {
                    return "Password must contain at least one special character";
                  }
                  return null;
                },
              ),
              15.height(),
              AuthGradientButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(
                          AuthSignUp(
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          ),
                        );
                  }
                  log(formKey.currentState!.validate().toString());
                },
                text: 'Sign Up',
              ),
              15.height(),
              GestureDetector(
                onTap: () => context.pushReplacement(const SignInPage()),
                child: RichText(
                    text: TextSpan(
                  text: "Already have an account? ",
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: "Sign in",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppPalette.gradient1,
                          ),
                    ),
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
