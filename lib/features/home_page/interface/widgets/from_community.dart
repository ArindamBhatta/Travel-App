import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

class FromCommunity extends StatelessWidget {
  final String mealImage;
  FromCommunity({
    required this.mealImage,
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
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: mealImage,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
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
                          const CircularProgressIndicator(
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

                  //* Heart button
                  Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: Transform.scale(
                      scale: 0.8,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withAlpha(50),
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: Colors.white,
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
                'location',
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
                      'state  , country',
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
