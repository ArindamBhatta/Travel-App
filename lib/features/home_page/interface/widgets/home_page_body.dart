import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/features/home_page/interface/widgets/publisher_card.dart';
import 'search_bar_container.dart';
import 'home_page_app_bar.dart';
import 'text_button_navigation.dart';

class HomePageBody extends StatelessWidget {
  final Map<String, dynamic>? userLoginData;
  final GlobalKey<ScaffoldState> _scaffoldKey;
  final List<String> textButtons;

  const HomePageBody({
    super.key,
    required GlobalKey<ScaffoldState> scaffoldKey,
    required this.userLoginData,
    required this.textButtons,
  }) : _scaffoldKey = scaffoldKey;

  Future<List<Map<String, dynamic>>> publisherData() async {
    QuerySnapshot<Map<String, dynamic>> jsonQuerySnapshot =
        await FirebaseFirestore.instance
            .collection('/destinations/publisher/data')
            .get();

    List<Map<String, dynamic>> publisherDataList = jsonQuerySnapshot.docs.map(
      (publisherDoc) {
        return publisherDoc.data();
      },
    ).toList();

    return publisherDataList;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          expandedHeight: 75.0,
          //* giving the flexible space title and background is their
          flexibleSpace: FlexibleSpaceBar(
            background: HomePageAppBar(
              userInfo: userLoginData,
              headingText: 'Wanderly',
              onAvatarTap: () =>
                  _scaffoldKey.currentState!.openDrawer(), //* Open the drawer
            ),
          ),
        ),
        //* make it's sticky
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
                      for (int index = 0; index < textButtons.length; index++)
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextButtonNavigation(
                            id: index,
                            buttonText: textButtons[index],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        FutureBuilder<List<Map<String, dynamic>>>(
          future: publisherData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SliverToBoxAdapter(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return SliverToBoxAdapter(
                child: Text('Some error is happen'),
              );
            } else if (snapshot.data!.isEmpty) {
              return SliverToBoxAdapter(
                child: Text('something happen'),
              );
            } else if (snapshot.hasData) {
              List<Map<String, dynamic>> publisherAllData = snapshot.data!;
              return SliverPadding(
                padding: EdgeInsets.all(16),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    Map<String, dynamic> singlePublisherData =
                        publisherAllData[index];
                    return PublisherCard(singlePublisherData);
                  }, childCount: publisherAllData.length),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
        )
      ],
    );
  }
}
