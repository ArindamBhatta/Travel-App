import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../../common/utils/google_login_provider.dart';
import '../../../common/utils/remote_data.dart';

import 'widgets/search_bar_container.dart';
import 'widgets/community_read_single_card.dart';
import 'widgets/app_bar_Content.dart';
import 'widgets/text_button_navigation.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    silentLoginWithAccessToken();
    //* Initialize the combined stream
  }

  @override
  void dispose() {
    //* Close the StreamController to avoid memory leaks
    streamController.close();
    super.dispose();
  }

  final StreamController<Map<String, dynamic>> streamController =
      StreamController<Map<String, dynamic>>();

//* The signInSilently method is part of the GoogleSignIn library,and its implementation interacts with native platform code to check if a user is already signed in without prompting for authentication again.
  void silentLoginWithAccessToken() async {
    //* only for android
    final GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await googleSignIn.signInSilently();
    try {
      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        print('SignIn Silently: ${googleAuth.idToken}');

        //* Set user data in provider
        context.read<GoogleLoginProvider>().setUserData({
          'name': googleUser.displayName,
          'photoUrl': googleUser.photoUrl,
        });
      }
    } catch (error) {
      print(error);
    }
  }

  //* want a single document then collection.doc()
  Future<Map<String, dynamic>?> getUser(String userUid) async {
    final DocumentReference getUserDocRef =
        FirebaseFirestore.instance.collection('users').doc(userUid);
    try {
      DocumentSnapshot docSnapshot = await getUserDocRef.get();
      if (docSnapshot.exists) {
        final userData = docSnapshot.data() as Map<String, dynamic>?;
        return userData;
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getContributions() async {
    try {
      //* if multiple document is their use query snapshot collection.get
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('/destinations/contributor/data')
          .get();

      List<Map<String, dynamic>> allContributions =
          querySnapshot.docs.map((individualDocument) {
        return individualDocument.data() as Map<String, dynamic>;
      }).toList();
      return allContributions;
    } catch (error) {
      print('Error fetching contributions data: $error');
      return [];
    }
  }

  Map<String, dynamic> data = {};

  Future<void> setStream(BuildContext context) async {
    String? userUid = context.read<GoogleLoginProvider>().userAccessToken;

    //*  Use Future.wait to execute both asynchronously
    try {
      final results = await Future.wait([
        getUser(userUid!),
        getContributions(),
      ]);

      final userData = results[0] as Map<String, dynamic>?;
      final contributions = results[1] as List<Map<String, dynamic>>;

      if (userData != null) {
        data['user'] = userData;
        data['contributions'] = contributions;

        streamController.add(data);
      } else {
        print('User data not found.');
      }
    } catch (error) {
      print('Error merging data: $error');
    }
  }

  bool init = false;

  @override
  Widget build(BuildContext context) {
    if (!init) {
      setStream(context);
      init = true;
    }

    return Scaffold(
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
                  headingText: 'Where do you Wish to go',
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
                  final Map<String, dynamic> comboData = data;
                  return SliverPadding(
                    padding: EdgeInsets.all(16),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          List<Map<String, dynamic>> allContributorData =
                              comboData['contributions'];
                          Map<String, dynamic> singleContributorData =
                              allContributorData[index];

                          final userData = comboData['user'];
                          if (userData == null) {
                            return SliverToBoxAdapter(
                              child: Center(
                                child: Text(
                                  'No data available for this document.',
                                ),
                              ),
                            );
                          }
                          //!Send to child
                          return CommunityReadSingleCard(
                            singleContributorData,
                            userData,
                          );
                        },
                        childCount: comboData.length,
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

  /*
     final DocumentReference getContributionsRef = FirebaseFirestore.instance
        .collection('/destinations/contributor/data')
        .doc();

        * The issue in your code is that you are trying to read a specific document (doc()) that doesn't already exist in Firestore.
        *When you call .doc() without passing an existing document ID, Firestore generates a new document reference with a random ID. Since this document doesn't exist in your Firestore collection, the get() call will not find any data.
        * To fetch multiple documents from a Firestore collection, you need to use a collection query instead of trying to fetch a single document. Here's how you can adjust your code to fetch all the documents in the data collection:
    
     Future<Map<String, dynamic>?> getAllContributions() async {
      try {
        DocumentSnapshot docSnapshot = await getContributionsRef.get();
        if (docSnapshot.exists) {
          final allContributions = docSnapshot.data() as Map<String, dynamic>?;

          return allContributions;
        }
      } catch (error) {
        print(
          'Error fetching user data: $error',
        );
      }
      return null;
    } */
// get the stream of the contributions via function reference
//   Stream<QuerySnapshot> getContributionsStream() {
//     return FirebaseFirestore.instance
//         .collection('/destinations/contributor/data')
//         .snapshots();
//   }
}
