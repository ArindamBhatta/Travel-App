import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/features/details_page/details_page_extension.dart';

class DetailsPage extends StatelessWidget {
  final String cardUniqueId;
  final bool checkWishList;
  final Function toggleWishList;
  final String imageUri;

  DetailsPage({
    super.key,
    required this.imageUri,
    required this.cardUniqueId,
    required this.checkWishList,
    required this.toggleWishList,
  });

/* 
* i use this in futureBuilder that why i can call like this way but if i want to get data from this method i needs to call another method 
Future<void> fetchData() async {
  var a = await collectionDocSnapshot();
  if (a != null) {
    print(' Data: $a');
  } else {
    print(' No data found or error occurred.');
  }
}
fetchData(); 
*/

  Future<Map<String, dynamic>?> fetchDetailsPageData() async {
    try {
      DocumentReference collectionDocSnapshot = FirebaseFirestore.instance
          .collection('/destinations/contributor/data')
          .doc(cardUniqueId);

      DocumentSnapshot docSnapshot = await collectionDocSnapshot.get();
      if (docSnapshot.exists) {
        return docSnapshot.data() as Map<String, dynamic>?;
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<Map<String, dynamic>?>(
        future: fetchDetailsPageData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading data'));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;

            return Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CachedNetworkImage(
                          imageUrl: imageUri,
                          fit: BoxFit.cover,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0),
                              ),
                              color: Colors.transparent,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                colorFilter: const ColorFilter.mode(
                                  Color.fromARGB(255, 254, 189, 184),
                                  BlendMode.colorBurn,
                                ),
                              ),
                            ),
                          ),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(
                            strokeWidth: 2.0,
                            color: Colors.black,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.green,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      // Arrow Icon
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
                      // Heart Icon
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
                              color: checkWishList ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              toggleWishList();
                            },
                          ),
                        ),
                      ),
                      // Bottom Container
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
                  name: data['name'] ?? 'N/A',
                  cost: data['cost'] ?? 'N/A',
                  rating: data['rating'] ?? 'N/A',
                  popularity: data['popularity'] ?? 0,
                  overview: data['overview'] ?? 'N/A',
                  details: data['details'] ?? 'N/A',
                  reviews: data['reviews'] ?? 'N/A',
                  duration: data['duration'] ?? 'N/A',
                  distance: data['distance'] ?? 'N/A',
                  weather: data['weather'] ?? 'N/A',
                ),
              ],
            );
          } else {
            // Handle empty data
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
