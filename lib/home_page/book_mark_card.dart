import 'package:flutter/material.dart';

import 'package:travel_app/destination_page/destination_page.dart';

class BookMarkCard extends StatelessWidget {
  final int id;
  final String? image;
  final bool bookMark;
  final String location;
  final String state;
  final String country;
  final VoidCallback toggleWishListMethod;

  BookMarkCard({
    super.key,
    required this.id,
    required this.image,
    required this.bookMark,
    required this.location,
    required this.state,
    required this.country,
    required this.toggleWishListMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DestinationPage(
                  id: id,
                ),
              ),
            );
          },
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Hero(
                        tag: id,
                        child: Container(
                          margin: EdgeInsets.all(8.0),
                          height: 180,
                          width: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            image: DecorationImage(
                              image: AssetImage(
                                image ?? '',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16.0,
                        right: 16.0,
                        child: Transform.scale(
                          scale: 0.8,
                          child: FloatingActionButton.small(
                            shape: CircleBorder(),
                            backgroundColor: Colors.white.withAlpha(50),
                            onPressed: () {
                              toggleWishListMethod();
                            },
                            child: Icon(
                              Icons.favorite,
                              color: bookMark ? Colors.red : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 16.0,
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 5),
                        Text(
                          location,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 20,
                          color: Colors.green,
                        ),
                        Text(
                          state + ', ' + country,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
