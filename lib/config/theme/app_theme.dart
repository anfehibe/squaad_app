import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() {
    const primary = Color.fromRGBO(245, 61, 51, 1);
    return ThemeData(
      colorSchemeSeed: primary,
      brightness: Brightness.dark,
      useMaterial3: true,
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
      ),
    );
  }
}
