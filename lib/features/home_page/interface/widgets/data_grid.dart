import 'package:flutter/material.dart';
import 'package:travel_app/features/home_page/interface/widgets/card_to_details_page.dart';
import 'package:travel_app/features/home_page/module/model/publisher_model.dart';

class DataGrid extends StatelessWidget {
  final bool isLoading;
  final List<PublisherModel>? allDestination;
  final List<String>? allDestinationKey;
  final List<dynamic>? userWishlist;

  DataGrid({
    required this.isLoading,
    required this.allDestination,
    required this.allDestinationKey,
    required this.userWishlist,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (allDestination == null && allDestinationKey == null ||
        allDestination!.isEmpty && allDestinationKey!.isEmpty) {
      return Center(
        child: Text('No data available'),
      );
    } else if (allDestination?.length != allDestination?.length) {
      return Center(
        child: Text('Some Error Happen'),
      );
    } else {
      return GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
        ),
        itemCount: allDestination?.length,
        itemBuilder: (context, index) {
          PublisherModel publisherSingleData = allDestination![index];
          String publisherDataKey = allDestinationKey![index];
          return CardToDetailsPage(
            destination: publisherSingleData,
            destinationKey: publisherDataKey,
            userWishlist: userWishlist,
          );
        },
      );
    }
  }
}
