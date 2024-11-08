import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/destination_page/details_page_extension.dart';
import '../home_page/provider/home_page_provider.dart';

class DetailsPage extends StatelessWidget {
  final int id;

  DetailsPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    String imageLink =
        Provider.of<HomePageProvider>(context).travelList[id]['image'];

    bool isWishList =
        Provider.of<HomePageProvider>(context).travelList[id]['isVisible'];

    String name =
        Provider.of<HomePageProvider>(context).travelList[id]['location'];

    String cost = Provider.of<HomePageProvider>(context).travelList[id]['cost'];

    String rating =
        Provider.of<HomePageProvider>(context).travelList[id]['rating'];

    int popularity =
        Provider.of<HomePageProvider>(context).travelList[id]['popularity'];

    String overview =
        Provider.of<HomePageProvider>(context).travelList[id]['overview'];

    String details =
        Provider.of<HomePageProvider>(context).travelList[id]['details'];

    String reviews =
        Provider.of<HomePageProvider>(context).travelList[id]['reviews'];

    String duration =
        Provider.of<HomePageProvider>(context).travelList[id]['duration'];

    String distance =
        Provider.of<HomePageProvider>(context).travelList[id]['distance'];

    String weather =
        Provider.of<HomePageProvider>(context).travelList[id]['weather'];

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
                        context
                            .read<HomePageProvider>()
                            .toggleWishList(id); //* toggle wish list
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: detailsPageExtension(
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
