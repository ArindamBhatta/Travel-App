import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/features/home_page/interface/widgets/side_drawer.dart';
import 'package:travel_app/features/home_page/module/model/destination_model.dart';
import 'package:travel_app/features/home_page/module/repo/home_page_repo.dart';
import '../../../common/utils/google_login_provider.dart';
import 'widgets/home_page_body.dart';

class HomePage extends StatefulWidget {
  final String? userAccessToken;
  HomePage(this.userAccessToken);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic>? userLoginData;

  void getRef() async {
    // Reference to the Firestore collection
    CollectionReference destinationDocumentPath =
        FirebaseFirestore.instance.collection('/destinations/publisher/data');

    // Fetch all documents in the collection
    QuerySnapshot publisherAllData = await destinationDocumentPath.get();

    // Loop through each document in the snapshot and print the document ID
    List<String> allDoc = publisherAllData.docs.map((publisherData) {
      return publisherData.id;
    }).toList();
    print(allDoc);
  }

  @override
  void initState() {
    super.initState();
    silentLoginWithAccessToken();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //* Google Sign In Silently
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

  Future<List<DestinationModel>?> fetchAllDestinationData() async {
    List<DestinationModel>? allPublisherData =
        await HomePageRepo.fetchDestinationData();
    return allPublisherData;
  }

  @override
  Widget build(BuildContext context) {
    getRef();

    userLoginData = context
        .watch<GoogleLoginProvider>()
        .userData; // watch user login details
    return Scaffold(
      drawer: SideDrawer(userLoginData),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: new HomePageBody(
          userLoginData: userLoginData,
        ),
      ),
    );
  }
}
