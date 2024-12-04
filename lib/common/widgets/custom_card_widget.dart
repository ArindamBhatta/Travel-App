import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  final String id;
  final String imageUri;
  final bool bookMark;
  final String location;
  final String state;
  final String country;
  final Function toggleWishList;

  CustomCardWidget({
    super.key,
    required this.id,
    required this.imageUri,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: imageUri,
                  fit: BoxFit.cover,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          8.0,
                        ),
                        topRight: Radius.circular(
                          8.0,
                        ),
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
                  //
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(
                    strokeWidth: 2.0,
                    color: Colors.black,
                    //
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.green,
                    ),
                  ),
                  //
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                  ),
                ),

                //* Heart button

                Positioned(
                  top: 10,
                  right: 10,
                  child: InkWell(
                    onTap: () {
                      print('Tap is done');
                      toggleWishList();
                    },
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
    );
  }
}
