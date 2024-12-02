import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleLoginProvider extends ChangeNotifier {
  Map<String, dynamic>? _userData;
  String? userAccessToken;

  List<DocumentReference>? allWishListReference = [];

  void setUserData(Map<String, dynamic>? data) {
    if (data != null) {
      _userData = {
        'name': data['name'] ?? '',
        'photoUrl': data['photoUrl'] ?? '',
      };
      notifyListeners();
    }
  }

  Map<String, dynamic>? get userData => _userData;

  void setAccessToken(String? accessToken) async {
    userAccessToken = accessToken;
    if (userAccessToken != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userAccessToken', userAccessToken!);
    }
    notifyListeners();
  }

  void getUserAccessToken() {
    SharedPreferences.getInstance().then((prefs) {
      userAccessToken = prefs.getString('userAccessToken');
      notifyListeners();
    });
  }

  void removeUserAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userAccessToken');
    notifyListeners();
  }
}
