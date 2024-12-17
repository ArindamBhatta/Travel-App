import 'package:flutter/material.dart';

abstract final class AppColors {
  //* Common color
  static final Color? baseColor = Colors.teal[400];
  static const Color textColorLightMode = Colors.black;
  static const Color? textColorDarkMood = Colors.white;
  static const Color dangerButton = Colors.red;

  static final ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Colors.teal, //* Main brand color
    onPrimary: Colors.white, //* Text/icon color on primary
    primaryContainer: Colors.teal[400], //* Subdued teal for containers
    onPrimaryContainer: Colors.red, //* Text color on primary container

    secondary: Colors.orangeAccent, //* Accent color for interactive elements
    onSecondary: Colors.white, //* Text/icon color on secondary
    secondaryContainer:
        Colors.orange.shade100, //* Subdued orange for containers
    onSecondaryContainer: Colors.orange.shade900, //* App background

    surface: Colors.white, //* Cards, sheets, etc.
    onSurface: Colors.teal, //* Text/icons on surface

    error: Colors.redAccent, //* Error color
    onError: Colors.white, //* Text/icons on error color
  );
}
