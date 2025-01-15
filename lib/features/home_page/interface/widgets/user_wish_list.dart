import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/features/home_page/interface/widgets/card_to_details_page.dart';
import 'package:travel_app/features/home_page/module/data/home_page_provider.dart';
import 'package:travel_app/features/home_page/module/model/publisher_model.dart';

class UserWishList extends StatelessWidget {
  final List<PublisherModel> allDestination;
  final List<dynamic>? userWishlist;

  UserWishList({
    required this.allDestination,
    required this.userWishlist,
  });
  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(
      builder: (context, provider, child) {
        List<PublisherModel>? wishListedDestination =
            provider.allWishListedData();

        if (wishListedDestination == null || wishListedDestination.isEmpty) {
          return Center(
            child: Text("No items in your wishlist."),
          );
        }

        return GridView.builder(
          padding: EdgeInsets.all(8.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.85,
          ),
          itemCount: wishListedDestination.length,
          itemBuilder: (context, index) {
            PublisherModel wishListedData = wishListedDestination[index];

            return CardToDetailsPage(
              destination: wishListedData,
              userWishlist: userWishlist,
            );
          },
        );
      },
    );
  }
}
