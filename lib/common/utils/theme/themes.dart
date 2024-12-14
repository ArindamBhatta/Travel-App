import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';
import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
    hintStyle: TextStyle(
      color: AppColors.textColorLightMode,
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
    ),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: AppColors.lightColorScheme,
    textTheme: GoogleFonts.poppinsTextTheme(),
    inputDecorationTheme: _inputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: AppColors.darkColorScheme,
    textTheme: GoogleFonts.poppinsTextTheme(),
    inputDecorationTheme: _inputDecorationTheme,
  );
}
