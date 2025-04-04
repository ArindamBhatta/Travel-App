import 'package:flutter/material.dart';
import 'package:travel_app/features/home/interface/widgets/card_to_details_page.dart';
import 'package:travel_app/features/home/module/model/publisher_model.dart';

class MostWishListed extends StatelessWidget {
  final List<PublisherModel> allDestination;
  final List<dynamic>? userWishlist;
  const MostWishListed({
    required this.allDestination,
    required this.userWishlist,
  });

  List<PublisherModel> filterBasedOnMostWish() {
    // Filter destinations where wishCount > 2 and sort them in descending order
    List<PublisherModel> mostWish = List.from(
        allDestination.where((destination) => (destination.wishCount ?? 0) > 2))
      ..sort((a, b) => (b.wishCount ?? 0).compareTo(a.wishCount ?? 0));

    // Check if the filtered list is empty before assigning it to mostWish
    if (mostWish.isNotEmpty) {
      print(mostWish.length);
      return mostWish;
    } else {
      print("No destinations with wishCount > 2");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    List<PublisherModel> mostWishListedData = filterBasedOnMostWish();
    return GridView.builder(
      padding: EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
      ),
      itemCount: mostWishListedData.length,
      itemBuilder: (context, index) {
        PublisherModel popularDestination = mostWishListedData[index];

        return CardToDetailsPage(
          destination: popularDestination,
          userWishlist: userWishlist,
        );
      },
    );
  }
}
