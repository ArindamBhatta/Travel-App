import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/features/home_page/module/model/publisher_model.dart';
import 'package:travel_app/features/home_page/module/repo/home_page_repo.dart';
import 'package:travel_app/features/introduction_page/model/google_login_provider.dart';

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

enum HomePageInnerNavigationButtonText {
  All('All'),
  WishListed('Wish Listed'),
  MostWished('Most wishful'),
  MostViewed('Most viewed');

  final String name;
  const HomePageInnerNavigationButtonText(this.name);
}

class HomePageProvider extends ChangeNotifier {
  bool isLoading = false;

  List<PublisherModel>? allPublisherData;
  List<dynamic>? userWishlist;

  List<String> userSelectedContinents = [];
  List<String> userSelectedTags = [];

  List<PublisherModel>? filteredDataBasedOnTap;
  List<PublisherModel>? filterDataBasedOnSearch;

  final DocumentReference userDocRef = FirebaseFirestore.instance
      .collection('users')
      .doc(GoogleLoginProvider.accessToken);

  // Fetch All Publisher Data
  void showPublisherData() async {
    isLoading = true;
    notifyListeners();
    try {
      allPublisherData = await HomePageRepo.fetchPublisherData();

      userWishlist = await HomePageRepo.userWishList();
    } catch (error) {
      print('Error fetching data: $error');
      allPublisherData = null;
      userWishlist = null;
    }
    isLoading = false;
    notifyListeners();
  }

  // Filter Publisher Data Based on User Selection
  void filterDataOnUserSelectedTap(
    List<String> selectedContinents,
    List<String> selectedTags,
  ) {
    try {
      // Ensure original data exists
      if (allPublisherData == null) {
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

      //* Step 2: - We get all data now Filter based on selected continents
      if (selectedContinents.isNotEmpty) {
        tempPublisherData = tempPublisherData.where(
          (destination) {
            return selectedContinents
                .any((continent) => destination.continent == continent);
          },
        ).toList();

        //* Step 3: - Filter based on selected tags
        if (selectedTags.isNotEmpty) {
          tempPublisherData = tempPublisherData.where((destination) {
            return selectedTags.any(
              (tag) => destination.tags!.contains(tag),
            );
          }).toList();

          filteredDataBasedOnTap = tempPublisherData;
          isLoading = false;
          notifyListeners();
        }
      }
    } catch (error) {
      print('Error in Filtering data $error');
    }
  }

  // Filter publisher data based on User Search
  void filterDataWhenSearch(String searchText) {
    try {
      if (searchText.isEmpty) {
        return;
      }

      if (allPublisherData == null) {
        isLoading = false;
        notifyListeners();
        print('Data is not present here');
        return;
      }

      isLoading = true;
      notifyListeners();

      // Filter results based on user input
      List<PublisherModel> clonePublisherData =
          List<PublisherModel>.from(allPublisherData!);

      String lowerCaseSearchText = searchText.toLowerCase().trim();

      clonePublisherData = clonePublisherData.where((destination) {
        return ((destination.name
                    ?.toLowerCase()
                    .contains(lowerCaseSearchText) ??
                false) ||
            (destination.country?.toLowerCase().contains(lowerCaseSearchText) ??
                false) ||
            (destination.continent
                    ?.toLowerCase()
                    .contains(lowerCaseSearchText) ??
                false) ||
            (destination.knownFor
                    ?.toLowerCase()
                    .contains(lowerCaseSearchText) ??
                false) ||
            (destination.tags?.any(
                    (tag) => tag.toLowerCase().contains(lowerCaseSearchText)) ??
                false));
      }).toList();

      // Assign the filtered data
      filterDataBasedOnSearch = clonePublisherData;
      notifyListeners();
      isLoading = false;
      notifyListeners();
    } catch (error) {
      print('Error in filtering data: $error');
      isLoading = false;
      notifyListeners();
    }
  }

// Fetch initial wishlist from Firestore and Assign to same variable either we needs snapshots.
  Future<void> fetchUserWishlist() async {
    try {
      final DocumentSnapshot snapshot = await userDocRef.get();

      final data = snapshot.data() as Map<String, dynamic>?;
      userWishlist = data?['wishlistLocations'] as List<dynamic>? ?? [];
      notifyListeners();
    } catch (error) {
      print('Error fetching wishlist: $error');
    }
  }

// Search All WishListed Data in Whole Data
  List<PublisherModel>? allWishListedData() {
    if (allPublisherData == null) {
      print('Data is not present here');
      return null;
    }

    return allPublisherData!
        .where(
          (destination) =>
              userWishlist != null &&
              userWishlist!.contains(
                destination.id,
              ),
        )
        .toList();
  }

  // Add item to wishlist
  Future<void> addToWishlist(String destinationId) async {
    if (!userWishlist!.contains(destinationId)) {
      userWishlist!.add(destinationId);
      notifyListeners(); // Update UI immediately

      try {
        // update in User Data
        await userDocRef.update({
          'wishlistLocations': FieldValue.arrayUnion([destinationId]),
        });
        // update in Specific Document wishCount
        await FirebaseFirestore.instance
            .collection('/destinations/publisher/data')
            .doc(destinationId)
            .update({
          'wishCount': FieldValue.increment(1),
        });
      } catch (error) {
        print('Error adding to wishlist: $error');
        userWishlist!.remove(destinationId); // restore local change
        notifyListeners();
      }
    }
  }

  // Remove item from wishlist
  Future<void> removeFromWishlist(String destinationId) async {
    if (userWishlist!.contains(destinationId)) {
      userWishlist!.remove(destinationId);
      notifyListeners(); // Update UI immediately

      try {
        // Remove in User Data
        await userDocRef.update({
          'wishlistLocations': FieldValue.arrayRemove([destinationId]),
        });
        // update in Specific Document wishCount
        await FirebaseFirestore.instance
            .collection('/destinations/publisher/data')
            .doc(destinationId)
            .update({
          'wishCount': FieldValue.increment(-1),
        });
      } catch (error) {
        print('Error removing from wishlist: $error');
        userWishlist!.add(destinationId); //restore the local change
        notifyListeners();
      }
    }
  }
}
