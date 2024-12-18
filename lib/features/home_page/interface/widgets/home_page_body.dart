import 'package:flutter/material.dart';
import 'search_bar_container.dart';
import 'card_view_to_details_page.dart';
import 'home_page_app_bar.dart';
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
              //*sliver grid
              return SliverPadding(
                padding: EdgeInsets.all(16),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    //* dynamically creating and managing child widgets within a SliverGrid just like SliverGrid.builder .
                    (
                      BuildContext context,
                      int index,
                    ) {
                      Map<String, dynamic> singleContributorData =
                          contributionsData[index];
                      return CardViewToDetailsPage(
                        singleContributorData,
                        userData,
                      );
                    },
                    childCount: contributionsData.length,
                  ),
                  //* gird view
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
