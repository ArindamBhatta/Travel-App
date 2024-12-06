import 'package:flutter/material.dart';

class DetailsPageProvider extends ChangeNotifier {
  int visibleButton = 0;

  void changeVisibility(int index) {
    if (visibleButton != index) {
      visibleButton = index;
    }
  }

  notifyListeners();
}
