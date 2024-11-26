import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  final int id;
  final String image;
  final bool bookMark;
  final String location;
  final String state;
  final String country;
  final Function toggleWishList;
  CustomCardWidget({
    super.key,
    required this.id,
    required this.image,
    required this.bookMark,
    required this.location,
    required this.state,
    required this.country,
    required this.toggleWishList,
  });
  @override
  Widget build(BuildContext context) {
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
                      height: 300,
                    ),
                  ),

                  //* Heart button

                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      onTap: () => toggleWishList(id),
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withAlpha(50),
                        ),
                        child: Icon(
                          Icons.favorite,
                          size: 20,
                          color: bookMark ? Colors.red : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //* location name
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                top: 10,
              ),
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
  }
}
