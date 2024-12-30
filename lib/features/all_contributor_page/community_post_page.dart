import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'widgets/community_post_body.dart';

class CommunityPostPage extends StatefulWidget {
  final String? userAccessToken;
  CommunityPostPage(this.userAccessToken);

  @override
  State<CommunityPostPage> createState() => _CommunityPostPageState();
}

class _CommunityPostPageState extends State<CommunityPostPage> {
  @override
  void initState() {
    super.initState();
    initStream(widget.userAccessToken);
  }

  final StreamController<Map<String, dynamic>> streamController =
      StreamController<Map<String, dynamic>>();

  final Map<String, dynamic> data = {};

  //* combine two streaming Data
  void initStream(userUid) {
    // create two property 1. allContributionData List of all contributed data, 2.userData particular user data.
    List<Map<String, dynamic>> allContributionsData = [];
    Map<String, dynamic>? userData;
    // create a stream using snapshots
    FirebaseFirestore.instance
        .collection('/destinations/contributor/data')
        .snapshots()
        .listen(
      (querySnapshot) {
        for (QueryDocumentSnapshot<Map<String, dynamic>> individualDoc
            in querySnapshot.docs) {
          allContributionsData.add(
            individualDoc.data(),
          );
        }
        data['contributions'] = allContributionsData;
      },
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .snapshots()
        .listen(
      (documentSnapshot) {
        if (documentSnapshot.exists) {
          userData = documentSnapshot.data();
          data['user'] = userData;
          streamController.add(data); //* finally add data to stream controller
        }
      },
    );
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // * functional  scope
    return Scaffold(
      resizeToAvoidBottomInset: false, //* fixed bottom sheet
      body: CommunityPostBody(
        streamController: streamController,
      ),
    );
  }
}
