import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final String imageUri;
  final Function toggleWishlist;
  final bool bookMark;
  ImageContainer(
    this.imageUri,
    this.toggleWishlist,
    this.bookMark,
  );
  @override
  Widget build(BuildContext context) {
    return Expanded(
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
              placeholder: (context, url) => CircularProgressIndicator(
                strokeWidth: 2.0,
                color: Colors.black,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.green,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
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
            child: InkWell(
              onTap: () {
                toggleWishlist();
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
    );
  }
}
