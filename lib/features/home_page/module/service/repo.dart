import 'package:travel_app/features/home_page/module/model/destination_model.dart';
import 'package:travel_app/features/home_page/module/service/home_page_service.dart';

abstract class HomeRepo {
  static Future<List<DestinationModel>?> accessDestinationData() async {
    try {
      List<Map<String, dynamic>>? data =
          await HomePageService.fetchPublisherData();
      List<DestinationModel> destinations = data.map((dataItem) {
        return new DestinationModel.fromJson(dataItem);
      }).toList();
      return destinations;
    } catch (error) {
      print("Error accessing destination data: $error");
      return null;
    }
  }
}
