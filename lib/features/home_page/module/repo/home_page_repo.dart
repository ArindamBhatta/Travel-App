import 'package:travel_app/features/home_page/module/model/publisher_model.dart';
import 'package:travel_app/features/home_page/module/service/home_page_service.dart';

abstract class HomePageRepo {
  // cachedCombinedData: This static field stores the fetched combined data locally.
  static Map<String, dynamic>? cachedCombinedData;

  // fetchCombinedDataCached: Checks if _cachedCombinedData is null. Fetches data only if it's not already cached.
  static Future<Map<String, dynamic>?> fetchCombinedDataCached() async {
    if (cachedCombinedData == null) {
      // singleton
      cachedCombinedData = await HomePageService.fetchAllFireStoreData();
    }
    return cachedCombinedData;
  }

  static Future<List<String>?> fetchPublisherDataKeys() async {
    try {
      Map<String, dynamic>? combinedData = await fetchCombinedDataCached();

      if (combinedData != null &&
          //Does Map Contain the Key
          combinedData.containsKey('publisherDataIds')) {
        List<String> publisherDataIds =
            combinedData['publisherDataIds'] as List<String>;
        return publisherDataIds;
      } else {
        return null;
      }
    } catch (error) {
      print("Error fetching publisher data keys: $error");
      return null;
    }
  }

  static Future<List<PublisherModel>?> fetchPublisherData() async {
    try {
      Map<String, dynamic>? combinedData = await fetchCombinedDataCached();
      if (combinedData != null && combinedData.containsKey('publisherData')) {
        List<Map<String, dynamic>> publisherData =
            combinedData['publisherData'] as List<Map<String, dynamic>>;

        List<PublisherModel> publisherDataModel = publisherData.map(
          (destination) {
            return PublisherModel.fromJson(destination);
          },
        ).toList();
        return publisherDataModel;
      } else {
        print('publisherData key not found in combinedData');
        return null;
      }
    } catch (error) {
      print("Error fetching publisher data: $error");
      return null;
    }
  }

  static Future<List<dynamic>?> userWishList() async {
    try {
      Map<String, dynamic>? combinedData = await fetchCombinedDataCached();

      if (combinedData != null && combinedData.containsKey('userData')) {
        Map<String, dynamic> userData =
            combinedData['userData'] as Map<String, dynamic>;

        // Extract and return wishlistLocations
        if (userData.containsKey('wishlistLocations')) {
          List<dynamic> wishList =
              userData['wishlistLocations'] as List<dynamic>;

          return wishList;
        } else {
          print("wishlistLocations not found in userData.");
          return [];
        }
      } else {
        return null;
      }
    } catch (error) {
      print("Error fetching user wishlist data: $error");
      return null;
    }
  }

  // refreshCombinedData: Allows manual refreshing of the cache, useful if the underlying data changes frequently.
  static Future<void> refreshCombinedData() async {
    cachedCombinedData = await HomePageService.fetchAllFireStoreData();
  }
}
