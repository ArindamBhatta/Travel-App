import 'package:travel_app/features/home_page/module/model/publisher_model.dart';
import 'package:travel_app/features/home_page/module/service/home_page_service.dart';

abstract class HomePageRepo {
  static Future<List<PublisherModel>?> fetchPublisherData() async {
    try {
      Map<String, dynamic>? combinedData =
          await HomePageService.fetchCombinedData();

      if (combinedData != null && combinedData.containsKey('publisherData')) {
        List<Map<String, dynamic>> publisherData =
            combinedData['publisherData'] as List<Map<String, dynamic>>;

        List<PublisherModel> publisherDataModel =
            publisherData.map((destination) {
          return new PublisherModel.fromJsonNameConstructor(destination);
        }).toList();
        print(
            'Successfully created DestinationModel list: $publisherDataModel');
        return publisherDataModel;
      } else {
        print('publisherData key not found in combinedData');
        return null;
      }
    } catch (error) {
      print("Error fetching combined data: $error");
      return null;
    }
  }

  static void fetchPublisherDataKeys() async {}
}
