import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/common/widgets/custom_card_widget.dart';

class CommunityReadSingleCard extends StatelessWidget {
  final Map<String, dynamic> data;
  CommunityReadSingleCard(
    this.data,
  );
  @override
  Widget build(BuildContext context) {
    String fetchId = data['id'];
    String fetchImageUri = data['image'];
    bool fetchBookmarkedData = data['isUserWishListedValue'];
    String fetchLocation = data['location'];
    String fetchCountry = data['country'];
    String fetchState = data['state'];

    void changeToWishList(String fetchId) async {
      final specificCommunityPost = FirebaseFirestore.instance
          .collection('/destinations/contributor/data')
          .doc(fetchId);

      try {
        //* Fetch the current document
        DocumentSnapshot snapshot = await specificCommunityPost.get();
        if (snapshot.exists) {
          //* Get the current value of 'isUserWishListedValue'
          bool currentValue = snapshot['isUserWishListedValue'] ?? false;

          //* Toggle the value
          bool newValue = !currentValue;

          //* firebase update method
          await specificCommunityPost.update(
            {
              'isUserWishListedValue': newValue,
            },
          );

          //* bottom message this card is wishlist
          print('Wishlist value toggled successfully');
        }
      } catch (error) {
        print('Error toggling wishlist value: $error');
      }
    }

    return CustomCardWidget(
      id: fetchId,
      imageUri: fetchImageUri,
      bookMark: fetchBookmarkedData,
      location: fetchLocation,
      state: fetchState,
      country: fetchCountry,
      toggleWishList: () {
        changeToWishList(fetchId);
      },
    );
  }
}
