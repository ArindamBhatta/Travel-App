import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:travel_app/features/home_page/interface/widgets/contributions_card.dart';

import '../../../details_page/details_page.dart';

class CommunityReadSingleCard extends StatelessWidget {
  final Map<String, dynamic> allContributorData;
  final Map<String, dynamic> userData;

  CommunityReadSingleCard(
    this.allContributorData,
    this.userData,
  );
  @override
  Widget build(BuildContext context) {
    String fetchCardId = allContributorData['id'];
    String fetchImageUri = allContributorData['image'];
    List fetchUserWishList = userData['wishlistLocation'];
    bool isInWishlist = fetchUserWishList.contains(fetchCardId);
    String fetchLocation = allContributorData['location'];
    String fetchCountry = allContributorData['country'];
    String fetchState = allContributorData['state'];
    DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(userData['uid']);

    DocumentReference fetchContributor = FirebaseFirestore.instance
        .collection('destinations/contributor/data')
        .doc(fetchCardId);

    void toggleWishList() async {
      try {
        if (isInWishlist) {
          await userDocRef.update(
            {
              'wishlistLocation': FieldValue.arrayRemove(
                  [fetchCardId]), //* remove any specific index
            },
          );
        } else {
          await userDocRef.update({
            'wishlistLocation': FieldValue.arrayUnion(
                [fetchCardId]), //* add any specific data in array.
          });
        }
        print('Wishlist updated successfully.');
      } catch (error) {
        print('Error updating wishlist: $error');
      }
    }

    return OpenContainer(
      closedElevation: 0.0,
      openElevation: 0.0,
      closedBuilder: (context, action) {
        return ContributionsCard(
          cardUniqueId: fetchCardId,
          imageUri: fetchImageUri,
          bookMark: isInWishlist,
          location: fetchLocation,
          state: fetchState,
          country: fetchCountry,
          toggleWishList: toggleWishList,
        );
      },
      openBuilder: (context, action) {
        return DetailsPage(
          cardUniqueId: fetchCardId,
          imageUri: fetchImageUri,
          bookMark: isInWishlist,
          toggleWishList: toggleWishList,
          uploadedUser: fetchContributor,
        );
      },
      transitionDuration: const Duration(
        milliseconds: 300,
      ),
    );
  }
}
