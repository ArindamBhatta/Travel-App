import 'package:flutter/material.dart';
import 'package:travel_app/common/utils/remote_data.dart';

class CardToDetailsPageProvider extends ChangeNotifier {
  //* if user tap a card it jump to details page
  Map<String, dynamic> filterForDetailsPage(int id) {
    return travelList.firstWhere(
      (data) => data['id'] == id,
    );
  }

  void toggleWishList(int idOfSpecificMap) {
    for (Map<String, dynamic> allElement in travelList) {
      if (allElement['id'] == idOfSpecificMap) {
        allElement['isUserWishListedValue'] =
            !allElement['isUserWishListedValue'];
        break;
      }
    }
    notifyListeners();
  }
}
