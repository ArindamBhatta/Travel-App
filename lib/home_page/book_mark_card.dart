import 'package:flutter/material.dart';

import 'package:travel_app/destination_page/details_page.dart';

class BookMarkCard extends StatelessWidget {
  final int id;
  final String image;
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
        //* GestureDetector or inkwell is used to make the card clickable.
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsPage(
                  //* passing those id coming from home pag, send to details page, check in json data for that id which map it render
                  id: id,
                ),
              ),
            );
          },
          child: Card(
            shadowColor: Colors.black,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Hero(
                          tag: id,
                          child: Image.asset(
                            image,
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      //* Heart button
                      Positioned(
                        top: 16.0,
                        right: 16.0,
                        child: Transform.scale(
                          scale: 0.8,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withAlpha(50),
                            ),
                            child: TextButton(
                              onPressed: toggleWishListMethod,
                              child: Icon(
                                Icons.favorite,
                                color: bookMark ? Colors.red : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  //* location name
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 10),
                    child: Row(
                      children: [
                        Text(
                          location,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //* icon location and state
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
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

/* 
  PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 1000),
      pageBuilder: (_, __, ___) => DestinationPage(id: id),
  ),
*/