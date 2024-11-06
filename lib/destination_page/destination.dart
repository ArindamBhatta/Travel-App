import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/destination_page/destination_description.dart';

import '../home_page/provider/wish_list_provider.dart';

class DestinationPage extends StatelessWidget {
  final int? id;

  DestinationPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    String imageLink =
        Provider.of<WishListProvider>(context).travelList[id!]['image'];

    bool? isWishList =
        Provider.of<WishListProvider>(context).travelList[id!]['isVisible'];

    String? name =
        Provider.of<WishListProvider>(context).travelList[id!]['name'];

    String? cost =
        Provider.of<WishListProvider>(context).travelList[id!]['cost'];

    String? rating =
        Provider.of<WishListProvider>(context).travelList[id!]['rating'];

    String? popularity =
        Provider.of<WishListProvider>(context).travelList[id!]['popularity'];

    String? overview =
        Provider.of<WishListProvider>(context).travelList[id!]['overview'];

    String? details =
        Provider.of<WishListProvider>(context).travelList[id!]['details'];

    String? reviews =
        Provider.of<WishListProvider>(context).travelList[id!]['reviews'];

    String? duration =
        Provider.of<WishListProvider>(context).travelList[id!]['duration'];

    String? distance =
        Provider.of<WishListProvider>(context).travelList[id!]['distance'];

    String? weather =
        Provider.of<WishListProvider>(context).travelList[id!]['weather'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: isWishList! ? Colors.red : Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 0,
            child: Image.asset(
              imageLink,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            child: Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: DestinationDescription(
                name: name,
                cost: cost,
                rating: rating,
                popularity: popularity,
                overview: overview,
                details: details,
                reviews: reviews,
                duration: duration,
                distance: distance,
                weather: weather,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
