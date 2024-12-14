import 'package:flutter/material.dart';

abstract final class AppColors {
  //* Common color
  static final Color? baseColor = Colors.teal[400];
  static const Color textColorLightMode = Colors.black;
  static const Color? textColorDarkMood = Colors.white;
  static const Color dangerButton = Colors.red;

  static final lightColorScheme = ColorScheme.fromSeed(
    seedColor: Colors.teal,
    brightness: Brightness.light,
    surface: Colors.teal[10],
    onPrimary: Colors.teal[400],
    primary: Colors.red[400],
  );

  static final darkColorScheme = ColorScheme.fromSeed(
    seedColor: Colors.teal,
    brightness: Brightness.dark,
    primary: Colors.white,
  );

  // static final lightColorScheme = ColorScheme(
  //   brightness: Brightness.light,
  //   primary: Colors.black,
  //   onPrimary: Colors.white,
  //   secondary: Colors.white10,
  //   onSecondary: Colors.white24,
  //   primaryContainer: baseColor,
  //   surface: Colors.white,
  //   error: Colors.red,
  //   onError: Colors.white,
  //   onSurface: Colors.white,
  // );

  // static const darkColorScheme = ColorScheme(
  //   brightness: Brightness.dark,
  //   primary: Colors.black,
  //   primaryContainer: baseColor,
  //   onPrimary: baseColor,
  //   secondary: Colors.white,
  //   onSecondary: Colors.white,
  //   surface: Colors.white,
  //   onSurface: Colors.white,
  //   error: Colors.black,
  //   onError: AppColors.dangerButton,
  // );
}
