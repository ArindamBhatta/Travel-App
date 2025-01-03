import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DestinationCard extends StatelessWidget {
  final String? imageUri;
  final String? name;
  final String? continent;
  final String? country;
  final bool bookmark;
  final void Function() toggleInFireStore;

  DestinationCard({
    required this.imageUri,
    required this.name,
    required this.continent,
    required this.country,
    required this.bookmark,
    required this.toggleInFireStore,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: '$imageUri',
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
                  placeholder: (context, url) => Center(
                    child: const CircularProgressIndicator(
                      strokeWidth: 2.0,
                      color: Colors.black,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.green,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                  ),
                ),

                //* Heart button

                Positioned(
                  top: 10,
                  right: 10,
                  child: InkWell(
                    onTap: toggleInFireStore,
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
                        color: this.bookmark ? Colors.red : Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          //* location name
          SizedBox(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$name',
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '$country , $continent',
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
