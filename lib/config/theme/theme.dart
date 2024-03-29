import 'package:blog_app/config/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([color = AppPalette.borderColor]) => OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: 2,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(8)));
  static final darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
      scaffoldBackgroundColor: AppPalette.backgroundColor,
      inputDecorationTheme: InputDecorationTheme(
          errorStyle: const TextStyle(color: Colors.red),
          enabledBorder: _border(),
          focusedBorder: _border(AppPalette.gradient1),
          errorBorder: _border(Colors.red),
          focusedErrorBorder: _border(Colors.red)),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppPalette.backgroundColor,
      ));
}
