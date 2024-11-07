import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/destination_page/destination_description.dart';
import '../home_page/provider/wish_list_provider.dart';

class DestinationPage extends StatelessWidget {
  final int id;

  DestinationPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    String imageLink =
        Provider.of<WishListProvider>(context).travelList[id]['image'];

    bool isWishList =
        Provider.of<WishListProvider>(context).travelList[id]['isVisible'];

    String name =
        Provider.of<WishListProvider>(context).travelList[id]['location'];

    String cost = Provider.of<WishListProvider>(context).travelList[id]['cost'];

    String rating =
        Provider.of<WishListProvider>(context).travelList[id]['rating'];

    String popularity =
        Provider.of<WishListProvider>(context).travelList[id]['popularity'];

    String overview =
        Provider.of<WishListProvider>(context).travelList[id]['overview'];

    String details =
        Provider.of<WishListProvider>(context).travelList[id]['details'];

    String reviews =
        Provider.of<WishListProvider>(context).travelList[id]['reviews'];

    String duration =
        Provider.of<WishListProvider>(context).travelList[id]['duration'];

    String distance =
        Provider.of<WishListProvider>(context).travelList[id]['distance'];

    String weather =
        Provider.of<WishListProvider>(context).travelList[id]['weather'];

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  bottom: height * 0.3,
                  child: Hero(
                    tag: id,
                    child: Image.asset(
                      imageLink, //* Destination Image
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                //* Arrow Icon
                Positioned(
                  top: 60,
                  left: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                //* Heart Icon
                Positioned(
                  top: 60,
                  right: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: isWishList ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        context.read<WishListProvider>().toggleWishList(id);
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: destinationDescription(
                    context: context,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
