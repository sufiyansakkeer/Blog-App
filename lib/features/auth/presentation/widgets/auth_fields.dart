import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  const AuthField({
    super.key,
    required this.hintText,
    required this.textEditingController,
    this.validator,
    this.obscureText = false,
  });
  final String hintText;
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(hintText: hintText),
      validator: (value) {
        if (value == null) {
          return "$hintText is Required";
        }
        return null;
      },
      obscureText: obscureText,
    );
  }
}
