import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:travel_app/features/home_page/interface/widgets/contributions_card.dart';

import '../../../details_page/details_page.dart';

class CommunityPostData extends StatelessWidget {
  final Map<String, dynamic> allContributorData;
  final Map<String, dynamic> userData;

  CommunityPostData(
    this.allContributorData,
    this.userData,
  );
  @override
  Widget build(BuildContext context) {
    String fetchCardId = allContributorData['id'];
    String fetchImageUri = allContributorData['image'];
    String fetchLocation = allContributorData['location'];
    String fetchCountry = allContributorData['country'];
    String fetchState = allContributorData['state'];
    List fetchUserWishList = userData['wishlistLocation'];
    bool isInWishlist = fetchUserWishList.contains(fetchCardId);
    DocumentReference fetchUserDetails = allContributorData['userRef'];

    final userDocRef =
        FirebaseFirestore.instance.collection('users').doc(userData['uid']);

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
        //* after tap passing the id to the details page.
        return DetailsPage(
          cardUniqueId: fetchCardId,
          imageUri: fetchImageUri,
          bookMark: isInWishlist,
          toggleWishList: toggleWishList,
          uploadedUser: fetchUserDetails,
        );
      },
      transitionDuration: const Duration(
        milliseconds: 300,
      ),
    );
  }
}
