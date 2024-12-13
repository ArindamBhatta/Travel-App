import 'package:flutter/material.dart';
import 'package:travel_app/common/utils/theme_data.dart';

class ThemeProvider extends ChangeNotifier {
  //*global scope
  ThemeData _themeData = MyThemes.lightTheme;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == MyThemes.lightTheme) {
      _themeData = MyThemes.darkTheme;
    } else {
      _themeData = MyThemes.lightTheme;
    }
    notifyListeners();
  }
}
