import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';
import 'package:flutter/material.dart';

abstract final class AppTheme {
  static final _textTheme = GoogleFonts.poppinsTextTheme().copyWith(
    headlineLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    headlineSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.grey3,
    ),
    labelSmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: AppColors.grey3,
    ),
    labelLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: AppColors.grey3,
    ),
  );

  //* defined a text style for both dark and light theme
  static const InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
    hintStyle: TextStyle(
      color: AppColors.grey3,
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
    ),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: AppColors.lightColorScheme,
    textTheme: _textTheme,
    //* button color
    elevatedButtonTheme: ElevatedButtonThemeData(),
    inputDecorationTheme: _inputDecorationTheme,
    extensions: [],
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: AppColors.darkColorScheme,
    textTheme: _textTheme,
    inputDecorationTheme: _inputDecorationTheme,
  );
}
