import 'package:flutter/material.dart';

class ThemeSwitchingProvider extends ChangeNotifier {
  ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      surface: Colors.white,
      primary: Colors.white,
    ),
    cardTheme: const CardTheme().copyWith(
      color: Colors.white,
    ),
  );

  ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      surface: Colors.grey.shade900,
    ),
    cardTheme: const CardTheme().copyWith(
      color: Colors.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal[500],
        foregroundColor: Colors.white,
      ),
    ),
  );
  //* global scope property
  ThemeData? themeMode;

  //*method
  void toggleTheme() {
    themeMode = (themeMode == lightMode) ? darkMode : lightMode;
    notifyListeners();
  }
}
