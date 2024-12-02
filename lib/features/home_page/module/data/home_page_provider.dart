import 'package:flutter/material.dart';
import '../../../../common/utils/remote_data.dart';

class HomePageProvider extends ChangeNotifier {
  int? textVisibilityIndex = 1;
  allButtonText selectedFilter = allButtonText.Popular;

  //* toggle between enum buttons
  void toggleTextVisibility(int? index) {
    if (textVisibilityIndex == index) {
      textVisibilityIndex = null;
    } else {
      textVisibilityIndex = index;
    }
    notifyListeners();
  }

  //* if user tap a card it jump to details page
  Map<String, dynamic> filterForDetailsPage(String id) {
    return travelList.firstWhere(
      (data) => data['id'] == id,
    );
  }

  void toggleWishList(String idOfSpecificMap) {
    for (Map<String, dynamic> allElement in travelList) {
      if (allElement['id'] == idOfSpecificMap) {
        allElement['isUserWishListedValue'] =
            !allElement['isUserWishListedValue'];
        break;
      }
    }
    notifyListeners();
  }

  //* Method to update the selected filter used in In TextButtonControlCard where enum is present.
  void updateFilter(allButtonText filter) {
    selectedFilter = filter;
    notifyListeners();
  }

  //* Filter for popular Items
  List<Map<String, dynamic>> filterForPopularList() {
    return travelList.where((allElement) {
      return allElement['popularity'] >= 10000;
    }).toList();
  }

  //* Filter for WishListed Items
  List<Map<String, dynamic>> filterForWishListedItems() {
    return travelList
        .where(
          (allElement) => allElement['isUserWishListedValue'] == true,
        )
        .toList();
  }

//* Used in HomePage.dart to build all card context
  List<Map<String, dynamic>> getFilteredTravelList() {
    switch (selectedFilter) {
      case allButtonText.Popular: //* if selectedFilter is enum Popular
        return filterForPopularList();
      case allButtonText.WishListed:
        return filterForWishListedItems();
      default:
        return travelList;
    }
  }

  // //* this method is used for rendering Homepage card context to select specific data which is needs for rendering.
  // List<Map<String, dynamic>> homePageFilteredData(
  //     List<Map<String, dynamic>> travelList) {
  //   return travelList.map((dataOneByOne) {
  //     return {
  //       'id': dataOneByOne['id'],
  //       'image': dataOneByOne['image'],
  //       'isUserWishListedValue': dataOneByOne['isUserWishListedValue'],
  //       'location': dataOneByOne['location'],
  //       'state': dataOneByOne['state'],
  //       'country': dataOneByOne['country'],
  //     };
  //   }).toList();
  // }
}
