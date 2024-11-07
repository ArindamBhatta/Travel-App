import 'package:flutter/material.dart';

class WishListProvider extends ChangeNotifier {
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
      'popularity': '10k',
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
      'overview':
          'Dharamshala is one of the world’s new holiday destinations in Himachal Pradesh. Located on the Himachal of the India.',
      'duration': '6 days',
      'distance': '10 km',
      'temperature': '18',
    },
    {
      'id': 3,
      'image': 'assets/images/bookmark_img_8.jpg',
      'isVisible': false,
      'location': 'Ranthambore National Park',
      'state': 'Rajasthan',
      'country': 'India',
      'overview':
          'Ranthambore is one of the world’s new holiday destinations in Rajasthan. Located on the Rajasthan of the India.',
      'duration': '4 days',
      'distance': '15 km',
      'weather': '23',
    },
    {
      'id': 4,
      'image': 'assets/images/bookmark_img_9.jpg',
      'isVisible': false,
      'location': 'Taj Mahal',
      'state': 'Agra',
      'country': 'India',
      'overview':
          'Taj Mahal is one of the world’s new holiday destinations in Agra. Located on the Agra of the India.',
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

  void toggleWishList(int index) {
    travelList[index]['isVisible'] = !travelList[index]['isVisible'];
    notifyListeners();
  }
}
