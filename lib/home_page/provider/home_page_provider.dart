import 'package:flutter/material.dart';

class HomePageProvider extends ChangeNotifier {
  int? textVisibilityIndex = 1;

  void toggleTextVisibility(int? index) {
    if (textVisibilityIndex == index) {
      textVisibilityIndex = null;
    } else {
      textVisibilityIndex = index;
    }
    notifyListeners();
  }

  //for Card Content
  List<Map<String, dynamic>> travelList = [
    {
      'id': 1,
      'image': 'assets/images/bookmark_img_6.jpg',
      'isVisible': false,
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
      'isVisible': false,
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
      'isVisible': false,
      'location': 'Ranthambore National Park',
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
      'isVisible': false,
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

  List<Map<String, dynamic>> wishListCardContent(
      List<Map<String, dynamic>> travelList) {
    //list in argument
    return travelList.map((item) {
      return {
        'id': item['id'],
        'image': item['image'],
        'isVisible': item['isVisible'],
        'location': item['location'],
        'state': item['state'],
        'country': item['country'],
      };
    }).toList(); //iterables to list
  }

  List<Map<String, dynamic>> filterForDetailsPage(int id) {
    return travelList.where((allElement) => allElement['id'] == id).toList();
  }

  List<Map<String, dynamic>> filterForPopularList() {
    return travelList.where((allElement) {
      return allElement['popularity'] >= 10000;
    }).toList();
  }

  void toggleWishList(int index) {
    travelList[index]['isVisible'] = !travelList[index]['isVisible'];
    notifyListeners();
  }
}

//Recommended card text

