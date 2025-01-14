import 'package:flutter/material.dart';
import 'package:travel_app/features/home_page/interface/widgets/card_to_details_page.dart';
import 'package:travel_app/features/home_page/module/model/publisher_model.dart';

class MostVisitedPage extends StatelessWidget {
  final List<PublisherModel>? allDestination;
  final List<dynamic>? userWishlist;

  MostVisitedPage({
    required this.allDestination,
    required this.userWishlist,
  });

  List<PublisherModel> ShortingData() {
    List<PublisherModel> filterBasedOnMostWatch =
        List.from(allDestination?.toList() ?? []);
    // Create a sorted list based on `viewCount`

    filterBasedOnMostWatch
        .sort((a, b) => (b.viewCount ?? 0).compareTo(a.viewCount ?? 0));

    return filterBasedOnMostWatch;
  }

  @override
  Widget build(BuildContext context) {
    List<PublisherModel> mostViewedData = ShortingData();
    return GridView.builder(
      padding: EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
      ),
      itemCount: mostViewedData.length,
      itemBuilder: (context, index) {
        PublisherModel popularDestination = mostViewedData[index];

        return CardToDetailsPage(
          destination: popularDestination,
          userWishlist: userWishlist,
        );
      },
    );
  }
}
