import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/features/details_page/details_page_extension.dart';
import '../home_page/module/data/home_page_provider.dart';

class DetailsPage extends StatelessWidget {
  final int id;

  DetailsPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> specificCardData =
        context.read<HomePageProvider>().filterForDetailsPage(id);

    String imageLink = specificCardData['image'];

    bool isWishList = specificCardData['isUserWishListedValue'];

    String location = specificCardData['location'];

    String cost = specificCardData['cost'];

    String rating = specificCardData['rating'];

    int popularity = specificCardData['popularity'];

    String overview = specificCardData['overview'];

    String details = specificCardData['details'];

    String reviews = specificCardData['reviews'];

    String duration = specificCardData['duration'];

    String distance = specificCardData['distance'];

    String weather = specificCardData['weather'];

    void toggleWishList(int dataId) {
      context.read<HomePageProvider>().toggleWishList(dataId);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    imageLink, //* Destination Image
                    height: double.infinity,
                    fit: BoxFit.cover,
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
                        toggleWishList(id);
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 20,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(50),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          detailsPageExtension(
            context: context,
            name: location,
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
        ],
      ),
    );
  }
}
