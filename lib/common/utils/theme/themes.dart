import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

abstract final class AppTheme {
  static const InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
    hintStyle: TextStyle(
      color: AppColors.dangerButton,
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
    ),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    //* default text
    inputDecorationTheme: _inputDecorationTheme,
    //! defined color as per Material 3 concept in abstract class
    colorScheme: AppColors.lightColorScheme,
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: Colors.black,
      displayColor: Colors.black,
    ),
//* Elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal[500],
        shadowColor: Colors.grey,
        iconColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    //* floating action button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
      foregroundColor: Colors.grey, // Icon/Text color
    ),
    iconTheme: IconThemeData(
      color: Colors.teal[400],
    ),
    dialogTheme: DialogTheme(
      iconColor: Colors.red,
    ),
  );
}
