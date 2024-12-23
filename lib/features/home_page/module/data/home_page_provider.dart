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

enum Tags {
  AdventureSports('Adventure sports'),
  Beach('Beach'),
  City('City'),
  CulturalExperiences('Cultural experiences'),
  Foodie('Foodie'),
  Hiking('Hiking'),
  Historic('Historic'),
  Island('Island'),
  Luxury('Luxury'),
  Mountain('Mountain'),
  Nightlife('Nightlife'),
  OffTheBeatenPath('Off-the-beaten-path'),
  Romantic('Romantic'),
  Rural('Rural'),
  Secluded('Secluded'),
  Sightseeing('Sightseeing'),
  Skiing('Skiing'),
  WineTasting('Wine tasting'),
  WinterDestination('Winter destination');

  final String name;
  const Tags(this.name);
}

IconData? tagsIcon(String tag) {
  return switch (tag) {
    'Adventure sports' => Icons.kayaking_outlined,
    'Beach' => Icons.beach_access_outlined,
    'City' => Icons.location_city_outlined,
    'Cultural experiences' => Icons.museum_outlined,
    'Foodie' || 'Food tours' => Icons.restaurant,
    'Hiking' => Icons.hiking,
    'Historic' => Icons.menu_book_outlined,
    'Island' || 'Coastal' || 'Lake' || 'River' => Icons.water,
    'Luxury' => Icons.attach_money_outlined,
    'Mountain' || 'Wildlife watching' => Icons.landscape_outlined,
    'Nightlife' => Icons.local_bar_outlined,
    'Off-the-beaten-path' => Icons.do_not_step_outlined,
    'Romantic' => Icons.favorite_border_outlined,
    'Rural' => Icons.agriculture_outlined,
    'Secluded' => Icons.church_outlined,
    'Sightseeing' => Icons.attractions_outlined,
    'Skiing' => Icons.downhill_skiing_outlined,
    'Wine tasting' => Icons.wine_bar_outlined,
    'Winter destination' => Icons.ac_unit,
    _ => Icons.label_outlined,
  };
}

enum Button {
  All('All'),
  Popular('Popular'),
  Recommended('Recommended'),
  MostReviewed('Most reviewed');

  final String name;
  const Button(this.name);
}

class HomePageProvider extends ChangeNotifier {
  //*global scope property
  int textVisibilityIndex = 1;
  Button currentButton = Button.Popular;

  void setCurrentContinent(Button continent, int index) {
    if (this.textVisibilityIndex != index) {
      this.textVisibilityIndex = index;
    }
    this.currentButton = continent;
    notifyListeners();
  }
}
