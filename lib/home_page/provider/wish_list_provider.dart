import 'package:flutter/material.dart';

class WishListProvider extends ChangeNotifier {
  List<Map<String, dynamic>> travelList = [
    {
      'image': 'assets/images/travel_img_6.jpg',
      'isVisible': false,
    },
    {
      'image': 'assets/images/travel_img_7.jpg',
      'isVisible': false,
    },
    {
      'image': 'assets/images/travel_img_8.jpg',
      'isVisible': false,
    },
    {
      'image': 'assets/images/travel_img_9.jpg',
      'isVisible': false,
    },
  ];

  void toggleWishList(int index) {
    travelList[index]['isVisible'] = !travelList[index]['isVisible'];
    notifyListeners();
  }
}
