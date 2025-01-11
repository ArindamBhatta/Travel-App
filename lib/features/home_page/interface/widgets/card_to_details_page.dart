import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/features/home_page/interface/widgets/destination_card.dart';
import 'package:travel_app/features/home_page/interface/widgets/destination_details.dart';
import 'package:travel_app/features/home_page/module/model/publisher_model.dart';

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

  @override
  void initState() {
    isInWishlist = widget.userWishlist != null &&
        widget.userWishlist!.contains(widget.destination.id);
    super.initState();
  }

  void toggleWishListInFireStore() async {
    final userDocRef = FirebaseFirestore.instance
        .collection('users')
        .doc('t5nmZmf1r8e6SwCqw3SJaeFoAY93');

    try {
      if (isInWishlist) {
        await userDocRef.update({
          'wishlistLocations': FieldValue.arrayRemove([widget.destination.id]),
        });
        setState(() {
          isInWishlist = false;
        });
      } else {
        await userDocRef.update({
          'wishlistLocations': FieldValue.arrayUnion([widget.destination.id]),
        });
        setState(
          () {
            isInWishlist = true;
          },
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: isInWishlist == true
              ? Text('Wishlist added successfully.')
              : Text('Wishlist remove successfully'),
        ),
      );
    } catch (error) {
      print('Error updating wishlist: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error updating wishlist. Please try again.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String? imageUri = widget.destination.imageUrl;
    String? name = widget.destination.name;
    String? continent = widget.destination.continent;
    String? country = widget.destination.country;
    String? knowFor = widget.destination.knownFor;
    List<String>? viewPoints = widget.destination.tags;

    return OpenContainer(
      closedElevation: 0.0,
      openElevation: 0.0,
      closedBuilder: (context, action) {
        return DestinationCard(
          imageUri: imageUri,
          name: name,
          country: country,
          continent: continent,
          bookmark: isInWishlist,
          toggleInFireStore: toggleWishListInFireStore,
        );
      },
      openBuilder: (context, action) {
        return DestinationDetails(
          imageUri: imageUri,
          name: name,
          country: country,
          continent: continent,
          knowFor: knowFor,
          viewPoints: viewPoints,
          bookmark: isInWishlist,
          toggleInFireStore: toggleWishListInFireStore,
        );
      },
    );
  }
}
