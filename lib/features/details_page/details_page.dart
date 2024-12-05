import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:travel_app/features/details_page/details_page_extension.dart';

class DetailsPage extends StatefulWidget {
  final String cardUniqueId;
  final bool bookMark;
  final Function toggleWishList;
  final String imageUri;
  final DocumentReference uploadedUser;

  DetailsPage({
    super.key,
    required this.imageUri,
    required this.cardUniqueId,
    required this.bookMark,
    required this.toggleWishList,
    required this.uploadedUser,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    bookmark = widget.bookMark;
    super.initState();
  }

  late bool bookmark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUri,
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
                  child: InkWell(
                    onTap: () {
                      widget.toggleWishList();
                      setState(
                        () {
                          bookmark = !bookmark;
                        },
                      );
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
                        color: bookmark ? Colors.red : Colors.white,
                      ),
                    ),
                  ),
                ),

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
          DetailsPageExtension(widget.uploadedUser),
        ],
      ),
    );
  }
}
