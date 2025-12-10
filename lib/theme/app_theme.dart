import 'package:flutter/material.dart';

class AppTheme {
  static const Color _primaryColor    = Color(0xFF6E69C8);
  static const Color _secondaryColor  = Color(0xFFD56957);
  static const Color _tertiaryColor   = Color(0xFF2a2832);
  static const Color _backgroundColor = Color(0XFF181824);
  static const Color _errorColor      = Colors.red;

  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: ColorScheme.dark(
        brightness: Brightness.dark,
        primary: _primaryColor,
        secondary: _secondaryColor,
        tertiary: _tertiaryColor,
        surface: _backgroundColor,
        error: _errorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
      ),
      useMaterial3: true,
      fontFamily: "PoiretOne",
    );
  }
}