import 'package:blog_app/my_app.dart';
import 'package:flutter/material.dart';

extension SnackBarExtension on String {
  void showSnack({Duration? duration, Color? backgroundColor}) {
    snackBarKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(this),
        duration: duration ?? const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
      ));
  }
}
