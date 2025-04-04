import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/features/home/interface/widgets/destination_card.dart';
import 'package:travel_app/features/home/interface/widgets/destination_details.dart';
import 'package:travel_app/features/home/module/data/home_page_provider.dart';
import 'package:travel_app/features/home/module/model/publisher_model.dart';

class CardToDetailsPage extends StatefulWidget {
  final PublisherModel destination;
  final List<dynamic>? userWishlist;

  CardToDetailsPage({
    super.key,
    required this.destination,
    required this.userWishlist,
  });

  @override
  _CardToDetailsPageState createState() => _CardToDetailsPageState();
}

class _CardToDetailsPageState extends State<CardToDetailsPage> {
  late bool isInWishlist;
  bool hasIncremented = false;

  @override
  void initState() {
    isInWishlist = widget.userWishlist != null &&
        widget.userWishlist!.contains(widget.destination.id);
    super.initState();
  }

  void toggleWishListInFireStore(BuildContext context) async {
    final provider = Provider.of<HomePageProvider>(context, listen: false);

    if (isInWishlist) {
      await provider.removeFromWishlist(widget.destination.id.toString());
    } else {
      await provider.addToWishlist(widget.destination.id.toString());
    }

    setState(() {
      isInWishlist = !isInWishlist;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isInWishlist
              ? 'Wishlist added successfully.'
              : 'Wishlist removed successfully.',
        ),
      ),
    );
  }

  //Increment the view count in Firebase
  void incrementViewCount() async {
    if (hasIncremented) return;
    hasIncremented = true;

    final destinationId = widget.destination.id;
    try {
      // Access Firestore and update the count property
      await FirebaseFirestore.instance
          .collection('/destinations/publisher/data')
          .doc(destinationId)
          .update({
        'viewCount': FieldValue.increment(1),
      });
    } catch (error) {
      print('Error incrementing view count: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // behavior: HitTestBehavior.deferToChild,
      onTap: () {},
      child: OpenContainer(
        closedElevation: 0.0,
        openElevation: 0.0,
        closedBuilder: (context, action) {
          return DestinationCard(
            imageUri: widget.destination.imageUrl,
            name: widget.destination.name,
            country: widget.destination.country,
            continent: widget.destination.continent,
            bookmark: isInWishlist,
            toggleInFireStore: () => toggleWishListInFireStore(context),
          );
        },
        openBuilder: (context, action) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            incrementViewCount();
          });
          return DestinationDetails(
            imageUri: widget.destination.imageUrl,
            name: widget.destination.name,
            country: widget.destination.country,
            continent: widget.destination.continent,
            knowFor: widget.destination.knownFor,
            viewPoints: widget.destination.tags,
            bookmark: isInWishlist,
            toggleInFireStore: () => toggleWishListInFireStore(context),
          );
        },
      ),
    );
  }
}
