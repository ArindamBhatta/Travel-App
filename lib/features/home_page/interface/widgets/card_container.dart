import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:travel_app/features/details_page/details_page.dart';

import '../../module/data/home_page_provider.dart';

class CardContainer extends StatelessWidget {
  final int id;
  final String image;
  final bool bookMark;
  final String location;
  final String state;
  final String country;

  const CardContainer({
    super.key,
    required this.id,
    required this.image,
    required this.bookMark,
    required this.location,
    required this.state,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    //* toggle wish list also done from details page pass to child card container
    void toggleWishList(int dataId) {
      context.read<HomePageProvider>().toggleWishList(dataId);
    }

    return OpenContainer(
      closedElevation: 0.0,
      openElevation: 0.0,
      closedBuilder: (context, action) {
        return Card(
          shadowColor: Colors.black,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 1,
          child: SizedBox(
            width: 210,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: Image.asset(
                          image,
                          alignment: Alignment.center,
                          fit: BoxFit.cover,
                          width: 400,
                          height: 400,
                        ),
                      ),

                      //* Heart button
                      Positioned(
                        top: 8.0,
                        right: 8.0,
                        child: Transform.scale(
                          scale: 0.8,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withAlpha(50),
                            ),
                            child: TextButton(
                              onPressed: () {
                                toggleWishList(id);
                              },
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
                ),

                //* location name
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Text(
                    location,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                //* icon location and state
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 5, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 20,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          '$state  , $country',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      openBuilder: (context, action) {
        return DetailsPage(
          id: id,
        );
      },
      transitionDuration: const Duration(
        milliseconds: 300,
      ),
    );
  }
}
