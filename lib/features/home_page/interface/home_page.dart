import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/features/home_page/interface/widgets/side_drawer.dart';
import '../../../common/utils/google_login_provider.dart';
import 'widgets/home_page_body.dart';

enum allButtonText { All, Popular, Recommended, WishListed }

class HomePage extends StatefulWidget {
  final String? userAccessToken;
  HomePage(this.userAccessToken);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //* global scope property
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final StreamController<Map<String, dynamic>> streamController =
      StreamController<Map<String, dynamic>>();

  final Map<String, dynamic> data = {};

  Map<String, dynamic>? userLoginData;
  List<String> textButtons = ['All', 'Popular', 'Recommended', 'WishListed'];

  //* method
  @override
  void initState() {
    super.initState();
    initStream(widget.userAccessToken);

    silentLoginWithAccessToken();
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  //* only for android
  void silentLoginWithAccessToken() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await googleSignIn.signInSilently();
    try {
      if (googleUser != null) {
        context.read<GoogleLoginProvider>().setUserData(
          {
            'email': googleUser.email,
            'name': googleUser.displayName,
            'photoUrl': googleUser.photoUrl,
          },
        );
      }
    } catch (error) {
      print(
        "error in silent login $error",
      );
    }
  }

  //* combine two streaming Data
  void initStream(userUid) {
    FirebaseFirestore.instance
        .collection('/destinations/contributor/data')
        .snapshots()
        .listen(
      (querySnapshot) {
        List<Map<String, dynamic>> contributions = []; //* empty list
        for (var individualDoc in querySnapshot.docs) {
          contributions.add(individualDoc.data());
        }
        data['contributions'] = contributions;
      },
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .snapshots()
        .listen(
      (documentSnapshot) {
        if (documentSnapshot.exists) {
          Map<String, dynamic>? userData = documentSnapshot.data();
          data['user'] = userData;
          streamController.add(data);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    userLoginData = context.watch<GoogleLoginProvider>().userData;

    // * functional  scope
    return Scaffold(
      key: _scaffoldKey, //* Scaffold key
      drawer: SideDrawer(userLoginData), //* Add the SideDrawer
      resizeToAvoidBottomInset: false, //* fixed bottom sheet

      body: SafeArea(
        child: HomePageBody(
          userLoginData: userLoginData,
          scaffoldKey: _scaffoldKey,
          textButtons: textButtons,
          streamController: streamController,
        ),
      ),
    );
  }
}
