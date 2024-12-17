import 'package:flutter/material.dart';
import 'search_bar_container.dart';
import 'card_view_to_details_page.dart';
import 'app_bar_content.dart';
import 'text_button_navigation.dart';
import 'dart:async';

class HomePageBody extends StatelessWidget {
  const HomePageBody({
    super.key,
    required this.userLoginData,
    required GlobalKey<ScaffoldState> scaffoldKey,
    required this.textButtons,
    required this.streamController,
  }) : _scaffoldKey = scaffoldKey;

  final Map<String, dynamic>? userLoginData;
  final GlobalKey<ScaffoldState> _scaffoldKey;
  final List<String> textButtons;
  final StreamController<Map<String, dynamic>> streamController;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          expandedHeight: 75.0,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            background: AppBarContent(
              userInfo: userLoginData,
              headingText: 'Wanderly',
              onAvatarTap: () =>
                  _scaffoldKey.currentState!.openDrawer(), // Open the drawer
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
                      return CardViewToDetailsPage(
                        singleContributorData,
                        userData,
                      );
                    },
                    childCount: contributionsData.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
    );
  }
}
