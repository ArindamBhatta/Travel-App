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
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signInSilently();
    if (googleUser != null) {
      context.read<GoogleLoginProvider>().setUserData({
        'name': googleUser.displayName,
        'photoUrl': googleUser.photoUrl,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
              stream: FirebaseFirestore.instance
                  .collection('/destinations/contributor/data')
                  .orderBy(
                    'timestamp',
                    descending: true,
                  )
                  .snapshots(),
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
