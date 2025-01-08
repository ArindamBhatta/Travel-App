import 'package:flutter/material.dart';
import 'package:travel_app/features/home_page/module/model/publisher_model.dart';
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
    _ => Icons.circle_outlined,
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

  bool isLoading = false; // for User something is coming their

  List<PublisherModel>? allPublisherData;
  List<String>? allPublisherDataKey;
  List<dynamic>? userWishlist;

  List<String> userSelectedContinents = [];
  List<String> userSelectedTags = [];

  List<PublisherModel>? filteredPublisherData;
  List<String>? filteredPublisherDataKey;

  void setCurrentContinent(Button continent, int index) {
    if (this.textVisibilityIndex != index) {
      this.textVisibilityIndex = index;
    }
    this.currentButton = continent;
    notifyListeners();
  }

  // Fetch All Publisher Data
  void showPublisherData() async {
    isLoading = true;
    notifyListeners();
    try {
      allPublisherData = await HomePageRepo.fetchPublisherData();
      allPublisherDataKey = await HomePageRepo.fetchPublisherDataKeys();
      userWishlist = await HomePageRepo.userWishList();
    } catch (error) {
      print('Error fetching data: $error');
      allPublisherData = null;
      allPublisherDataKey = null;
      userWishlist = null;
    }
    isLoading = false;
    notifyListeners();
  }

  // Filter Publisher Data Based on User Selection

  void filterPublisherData(
      List<String> selectedContinents, List<String> selectedTags) {
    try {
      // Ensure original data exists
      if (allPublisherData == null || allPublisherDataKey == null) {
        isLoading = false;
        notifyListeners();
        print('Data is not present here');
        return;
      }

      isLoading = true;
      notifyListeners();

      // Create temporary filtered lists
      List<PublisherModel>? tempPublisherData =
          List<PublisherModel>.from(allPublisherData!);

      List<String>? tempPublisherDataKey =
          List<String>.from(allPublisherDataKey!);

      // Filter based on selected continents
      if (selectedContinents.isNotEmpty) {
        List<int> matchingIndexes = [];
        tempPublisherData = tempPublisherData.where((destination) {
          int index = allPublisherData!.indexOf(destination);
          if (selectedContinents
              .any((continent) => destination.continent == continent)) {
            matchingIndexes.add(index);
            return true;
          }
          return false;
        }).toList();

        tempPublisherDataKey = matchingIndexes
            .map((index) => allPublisherDataKey![index])
            .toList();
      }

      // Filter based on selected tags
      if (selectedTags.isNotEmpty) {
        List<int> matchingIndexes = [];
        tempPublisherData = tempPublisherData.where((destination) {
          int index = allPublisherData!.indexOf(destination);
          if (selectedTags.any((tag) => destination.tags!.contains(tag))) {
            matchingIndexes.add(index);
            return true;
          }
          return false;
        }).toList();

        tempPublisherDataKey =
            matchingIndexes.map((i) => allPublisherDataKey![i]).toList();
      }

      // Assign filtered results to separate properties
      filteredPublisherData = tempPublisherData;
      filteredPublisherDataKey = tempPublisherDataKey;

      isLoading = false;
      notifyListeners();
    } catch (error) {
      isLoading = false;
      notifyListeners();
      print('Error in filtering data: $error');
    }
  }
}
