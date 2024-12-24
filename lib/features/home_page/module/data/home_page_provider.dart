import 'package:flutter/material.dart';
import 'package:travel_app/features/home_page/module/model/destination_model.dart';
import 'package:travel_app/features/home_page/module/repo/home_page_repo.dart';

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
  //*global scope property for [all, popular, recommended]
  int textVisibilityIndex = 0;
  Button currentButton = Button.All;

  List<DestinationModel>? allPublisherData;

  //*global scope property for search bar filter [Asia, 'North America'];
  List<String> userSelectedContinents = [];
  List<String> userSelectedTags = [];

  void setCurrentContinent(Button continent, int index) {
    if (this.textVisibilityIndex != index) {
      this.textVisibilityIndex = index;
    }
    this.currentButton = continent;
    notifyListeners();
  }

  void fetchAllDestinationData() async {
    allPublisherData = await HomePageRepo.fetchDestinationData();
  }

  Future<List<DestinationModel>?> getFilterPublisherData() async {
    //*Step 1: - Fetch all publisher data
    List<DestinationModel>? allPublisherData =
        await HomePageRepo.fetchDestinationData();

    //* Step 2: - Filter based on selected continents
    if (userSelectedContinents.length != 0) {
      List<DestinationModel>? continentBaseFilteredData =
          allPublisherData?.where((destination) {
        return userSelectedContinents
            .any((continent) => //* check with firebase data
                destination.continent == continent);
      }).toList();

      //* Step 3: - Filter based on selected tags
      if (userSelectedTags.length != 0) {
        List<DestinationModel>? filteredData = continentBaseFilteredData?.where(
          (destination) {
            return userSelectedTags.any((tag) =>
                //* check with firebase tags[element1, element2, element3] contains method
                destination.tags!.contains(tag));
          },
        ).toList();
        notifyListeners();
        return filteredData;
      } else {
        notifyListeners();
        return continentBaseFilteredData;
      }
    } else {
      notifyListeners();
      return allPublisherData;
    }
  }
}
