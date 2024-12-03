import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/common/utils/google_login_provider.dart';
import 'package:travel_app/common/widgets/custom_card_widget.dart';

class CommunityReadSingleCard extends StatelessWidget {
  final Map<String, dynamic> data;
  CommunityReadSingleCard(
    this.data,
  );
  @override
  Widget build(BuildContext context) {
    String? userUid = context.watch<GoogleLoginProvider>().userAccessToken;
    String fetchId = data['id'];
    String fetchImageUri = data['image'];
    bool fetchBookmarkedData = data['isUserWishListedValue'];
    String fetchLocation = data['location'];
    String fetchCountry = data['country'];
    String fetchState = data['state'];
    final DocumentReference getCurrentUserDocRef =
        FirebaseFirestore.instance.collection('users').doc(userUid);

    void getCurrentUserRef() async {
      try {
        DocumentSnapshot docSnapshot = await getCurrentUserDocRef.get();

        if (docSnapshot.exists) {
          final userData = docSnapshot.data() as Map<String, dynamic>?;
        }
      } catch (error) {
        print(
          'Error fetching user data: $error',
        );
      }
    }

    return CustomCardWidget(
      id: fetchId,
      imageUri: fetchImageUri,
      bookMark: fetchBookmarkedData,
      location: fetchLocation,
      state: fetchState,
      country: fetchCountry,
      toggleWishList: () {},
    );
  }
}
