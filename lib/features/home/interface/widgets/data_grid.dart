import 'package:flutter/material.dart';
import 'package:travel_app/features/home/interface/widgets/card_to_details_page.dart';
import 'package:travel_app/features/home/module/model/publisher_model.dart';

class DataGrid extends StatelessWidget {
  final bool isLoading;
  final List<PublisherModel>? allDestination;

  final List<dynamic>? userWishlist;

  DataGrid({
    required this.isLoading,
    required this.allDestination,
    required this.userWishlist,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (allDestination == null || allDestination!.isEmpty) {
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

          return CardToDetailsPage(
            destination: publisherSingleData,
            userWishlist: userWishlist,
          );
        },
      );
    }
  }
}
