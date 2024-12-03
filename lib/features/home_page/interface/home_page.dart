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
  }

  StreamConsumer<dynamic> streamController = StreamController<dynamic>();

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

//* get the stream of the contributions via function reference
  Stream<QuerySnapshot> getContributionsStream() {
    return FirebaseFirestore.instance
        .collection('/destinations/contributor/data')
        .snapshots();
  }

  Future<Map<String, dynamic>?> setStream(BuildContext context) async {
    String? userUid = context.watch<GoogleLoginProvider>().userAccessToken;
    //* want a single document then collection.doc()
    final DocumentReference getUserDocRef =
        FirebaseFirestore.instance.collection('users').doc(userUid);

    Future<Map<String, dynamic>?> getUser() async {
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

    Future<List<Map<String, dynamic>>> getContributions() async {
      try {
        //* if multiple document is their use query snapshot collection.get
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('/destinations/contributor/data')
            .get();
        print('querySnapshot -> 👍 $querySnapshot');

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

    //*  Use Future.wait to execute both asynchronously
    try {
      final results = await Future.wait([
        getUser(),
        getContributions(),
      ]);

      final userData = results[0] as Map<String, dynamic>?;
      final contributions = results[1] as List<Map<String, dynamic>>;

      if (userData != null) {
        //* Merge user data and contributions
        return {
          'user': userData,
          'contributions': contributions,
        };
      } else {
        print('User data not found.');
        return null;
      }
    } catch (error) {
      print('Error merging data: $error');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>?> data = setStream(context);
    streamController.add(data);

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
            //! merge two string in stream property.
            StreamBuilder<QuerySnapshot>(
              stream: getContributionsStream(),
              builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      height: 100,
                      child: Center(
                        child: Text(
                          'No user  upload their views',
                        ),
                      ),
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
                  final List<QueryDocumentSnapshot> destinations =
                      snapshot.data!.docs;

                  return SliverPadding(
                    padding: EdgeInsets.all(16),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final allContributorData = destinations[index].data();
                          if (allContributorData == null) {
                            return SliverToBoxAdapter(
                              child: Center(
                                child: Text(
                                  'No data available for this document.',
                                ),
                              ),
                            );
                          }
                          final data =
                              allContributorData as Map<String, dynamic>;
                          //!Send to child
                          return CommunityReadSingleCard(data);
                        },
                        childCount: destinations.length,
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
