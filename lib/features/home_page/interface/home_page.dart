import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/features/home_page/interface/widgets/side_drawer.dart';

import '../../../common/utils/google_login_provider.dart';
import '../../../common/utils/remote_data.dart';

import 'widgets/search_bar_container.dart';
import 'widgets/community_post_data.dart';
import 'widgets/app_bar_Content.dart';
import 'widgets/text_button_navigation.dart';

class HomePage extends StatefulWidget {
  final String? userAccessToken;
  HomePage(this.userAccessToken);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //* global scope property or has part
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final StreamController<Map<String, dynamic>> streamController =
      StreamController<Map<String, dynamic>>();

  final Map<String, dynamic> data = {};

  Map<String, dynamic>? userLoginData;

  //* global scope method or Do part
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

  void silentLoginWithAccessToken() async {
    //* only for android
    final GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await googleSignIn.signInSilently();
    try {
      if (googleUser != null) {
        context.read<GoogleLoginProvider>().setUserData(
          {
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

    //* functional  scope
    return Scaffold(
      key: _scaffoldKey, // Assign the key to the Scaffold

      drawer: SideDrawer(userLoginData), // Add the SideDrawer
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              elevation: 0,
              expandedHeight: 75.0,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: AppBarContent(
                  userInfo: userLoginData,
                  headingText: 'Welcome to Travel App',
                  onAvatarTap: () => _scaffoldKey.currentState!
                      .openDrawer(), // Open the drawer
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: SearchBarContainer(),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        children: [
                          TextButtonNavigation(
                            id: 0,
                            buttonText: allButtonText.All.name,
                          ),
                          const SizedBox(width: 8),
                          TextButtonNavigation(
                            id: 1,
                            buttonText: allButtonText.Popular.name,
                          ),
                          const SizedBox(width: 8),
                          TextButtonNavigation(
                            id: 2,
                            buttonText: allButtonText.Recommended.name,
                          ),
                          const SizedBox(width: 8),
                          TextButtonNavigation(
                            id: 3,
                            buttonText: allButtonText.WishListed.name,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            StreamBuilder<Map<String, dynamic>>(
              stream: streamController.stream,
              builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'unable to fetch data right now, try again later .',
                      ),
                    ),
                  );
                } else if (snapshot.hasData) {
                  final Map<String, dynamic> comboData = snapshot.data!;
                  List<Map<String, dynamic>> contributionsData =
                      comboData['contributions'];
                  Map<String, dynamic> userData = comboData['user'];

                  if (contributionsData.length == 0) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          'No User Post yet.',
                        ),
                      ),
                    );
                  }

                  return SliverPadding(
                    padding: EdgeInsets.all(16),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          Map<String, dynamic> singleContributorData =
                              contributionsData[index];
                          return CommunityPostData(
                            singleContributorData,
                            userData,
                          );
                        },
                        childCount: contributionsData.length,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.85,
                      ),
                    ),
                  );
                } else {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text('Something happen'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
