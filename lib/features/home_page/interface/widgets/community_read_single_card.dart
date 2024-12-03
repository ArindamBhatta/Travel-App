import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/common/utils/google_login_provider.dart';
import 'package:travel_app/common/widgets/custom_card_widget.dart';

class CommunityReadSingleCard extends StatelessWidget {
  final Map<String, dynamic> allContributorData;
  final Map<String, dynamic> userData;

  CommunityReadSingleCard(
    this.allContributorData,
    this.userData,
  );
  @override
  Widget build(BuildContext context) {
    String? userUid = context.read<GoogleLoginProvider>().userAccessToken;
    String fetchId = allContributorData['id'];
    String fetchImageUri = allContributorData['image'];
    bool fetchBookmarkedData = allContributorData['isUserWishListedValue'];
    String fetchLocation = allContributorData['location'];
    String fetchCountry = allContributorData['country'];
    String fetchState = allContributorData['state'];
    final DocumentReference getCurrentUserDocRef =
        FirebaseFirestore.instance.collection('users').doc(userUid);

    void pushToUserWishListArray() async {
      fetchBookmarkedData != fetchBookmarkedData;
      print(fetchBookmarkedData);
      getCurrentUserDocRef.update(
        {
          "isUserWishListedValue": true,
        },
      );
    }

    return CustomCardWidget(
      id: fetchId,
      imageUri: fetchImageUri,
      bookMark: fetchBookmarkedData,
      location: fetchLocation,
      state: fetchState,
      country: fetchCountry,
      toggleWishList: pushToUserWishListArray,
    );
  }
}
