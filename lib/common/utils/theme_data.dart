import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(),
    appBarTheme: AppBarTheme(color: Colors.grey.shade900),

    //* card-theme
    cardTheme: CardTheme(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
    ),

    //* text-theme
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),

    //* elevation-button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal[700],
        shadowColor: Colors.black,
        iconColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),

    //* text-button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey.shade900,
        textStyle: TextStyle().copyWith(),
      ),
    ),

    //* floating action button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: sqrt1_2,
    ),

    //* drawer
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.grey.shade900,
    ),

    //* iconTheme
    iconTheme: IconThemeData(
      color: Colors.teal[700],
    ),
  );

  //! light Mode

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
    cardColor: Colors.grey.shade100,

    //* elevatedButton
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.teal[500],
        shadowColor: Colors.grey,
        iconColor: Colors.white,
        textStyle: TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    //
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: Colors.black,
      displayColor: Colors.black,
    ),
    //*card
    cardTheme: CardTheme(
      margin: EdgeInsets.zero,
      elevation: 0.5,
      color: Colors.grey.shade100,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(8.0),
        ),
        side: BorderSide(
          color: Colors.grey.shade100,
          width: 0.5,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        // textStyle: TextStyle(),
        textStyle: TextStyle().copyWith(),
      ),
    ),
    //* floating action button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
      foregroundColor: Colors.white, // Icon/Text color
    ),

    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.white,
    ),

    iconTheme: IconThemeData(
      color: Colors.teal[400],
    ),
  );
}
