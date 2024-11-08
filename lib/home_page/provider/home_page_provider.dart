import 'package:flutter/material.dart';

enum allButtonText { All, Popular, Recommended, WishListed }

class HomePageProvider extends ChangeNotifier {
  int? textVisibilityIndex = 1;
  allButtonText selectedFilter = allButtonText.Popular;

  //* this method is used to toggle between enum buttons used in TextButtonControlCard
  void toggleTextVisibility(int? index) {
    if (textVisibilityIndex == index) {
      textVisibilityIndex = null;
    } else {
      textVisibilityIndex = index;
    }
    notifyListeners();
  }

  //* this method is used for details page specification if user tap a card it go to that card details page
  List<Map<String, dynamic>> filterForDetailsPage(int id) {
    return travelList.where((allElement) {
      return allElement['id'] == id;
    }).toList();
  }

  //* control by both home page card and details page isUserWishListedValue property which is a json value
  void toggleWishList(int index) {
    travelList[index]['isUserWishListedValue'] =
        !travelList[index]['isUserWishListedValue'];
    notifyListeners();
  }

  //* this method is used for rendering Homepage card context to select specific data which is needs for rendering.
  List<Map<String, dynamic>> homePageFilteredData(
      List<Map<String, dynamic>> travelList) {
    return travelList.map((dataOneByOne) {
      return {
        'id': dataOneByOne['id'],
        'image': dataOneByOne['image'],
        'isUserWishListedValue': dataOneByOne['isUserWishListedValue'],
        'location': dataOneByOne['location'],
        'state': dataOneByOne['state'],
        'country': dataOneByOne['country'],
      };
    }).toList();
  }

  //* Method to update the selected filter used in In TextButtonControlCard where enum is present.
  void updateFilter(allButtonText filter) {
    selectedFilter = filter;
    notifyListeners();
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

  //* Filter for popular Items
  List<Map<String, dynamic>> filterForPopularList() {
    return travelList.where((allElement) {
      return allElement['popularity'] >= 10000;
    }).toList();
  }

  //* Filter for WishListed Items
  List<Map<String, dynamic>> filterForWishListedItems() {
    return travelList.where((allElement) {
      notifyListeners();
      print('-------------------${allElement['isUserWishListedValue']}');
      return allElement['isUserWishListedValue'] == true;
    }).toList();
  }

  //* Check it's a length issue? no the issue is Keys
  // List<Map<String, dynamic>> getFilterList() {
  //   List<Map<String, dynamic>> filterList = filterForWishListedItems();
  //   print('---------------------------->>>>>> ${filterList.length}');
  //   return filterList;
  // }

  List<Map<String, dynamic>> travelList = [
    {
      'id': 1,
      'image': 'assets/images/bookmark_img_6.jpg',
      'isUserWishListedValue': false,
      'location': 'Darjeeling',
      'state': 'West Bengal',
      'country': 'India',
      'cost': '5000',
      'rating': '4.5',
      'popularity': 10000000,
      'overview':
          'Darjeeling is one of the world’s new holiday destinations in West Bengal. Located on the west Bengal of the India.',
      'details': 'Dharamshala, Darjeeling, India',
      'reviews': 'most reviewed places in India',
      'duration': '4 days',
      'distance': '2.5 km',
      'weather': '13',
    },
    {
      'id': 2,
      'image': 'assets/images/bookmark_img_7.jpg',
      'isUserWishListedValue': false,
      'location': 'Dharamshala',
      'state': 'Himachal Pradesh',
      'country': 'India',
      'cost': '4500',
      'rating': '4.6',
      'popularity': 10000000,
      'overview':
          'Dharamshala is one of the world’s new holiday destinations in Himachal Pradesh. Located on the Himachal of the India.',
      'details': 'Dharamshala, Himachal Pradesh, India',
      'reviews': 'most reviewed places in India',
      'duration': '6 days',
      'distance': '10 km',
      'weather': '18',
    },
    {
      'id': 3,
      'image': 'assets/images/bookmark_img_8.jpg',
      'isUserWishListedValue': false,
      'location': 'Ranthambore Park',
      'state': 'Rajasthan',
      'country': 'India',
      'cost': '6000',
      'rating': '4.3',
      'popularity': 10000000,
      'overview':
          'Ranthambore is one of the world’s new holiday destinations in Rajasthan. Located on the Rajasthan of the India.',
      'details': 'Ranthambore, Rajasthan, India',
      'reviews': 'most reviewed places in India',
      'duration': '4 days',
      'distance': '15 km',
      'weather': '23', // Consistent key naming
    },
    {
      'id': 4,
      'image': 'assets/images/bookmark_img_9.jpg',
      'isUserWishListedValue': false,
      'location': 'Taj Mahal',
      'state': 'Agra',
      'country': 'India',
      'cost': '7000',
      'rating': '4.8',
      'popularity': 100,
      'overview':
          'Taj Mahal is one of the world’s new holiday destinations in Agra. Located on the Agra of the India.',
      'details': 'Taj Mahal, Agra, India',
      'reviews': 'most reviewed places in India',
      'duration': '4 days',
      'distance': '20 km',
      'weather': 'Rainy',
    },
  ];
}
