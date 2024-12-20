import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum Continent {
  asia('Asia'),
  africa('Africa'),
  northAmerica('North America'),
  southAmerica('South America'),
  antarctica('Antarctica'),
  europe('Europe'),
  australia('Australia'),
  oceania('Oceania');

  final String name;
  const Continent(this.name);
}

class HomePageProvider extends ChangeNotifier {
  //*global scope property
  int textVisibilityIndex = 0;
  Continent currentContinent = Continent.asia;

  Future<List<Map<String, dynamic>>> fetchPublisherData() async {
    QuerySnapshot<Map<String, dynamic>> jsonQuerySnapshot =
        await FirebaseFirestore.instance
            .collection('/destinations/publisher/data')
            .get();

    List<Map<String, dynamic>> publisherDataList = jsonQuerySnapshot.docs.map(
      (publisherDoc) {
        return publisherDoc.data();
      },
    ).toList();
    return publisherDataList;
  }

  void toggleTextVisibility(int index) {
    if (this.textVisibilityIndex != index) {
      this.textVisibilityIndex = index;
    }
    notifyListeners();
  }

  void setCurrentContinent(Continent continent) {
    this.currentContinent = continent;
    notifyListeners();
  }
}
