import 'package:flutter/material.dart';
import 'package:travel_app/features/home_page/interface/home_page.dart';
import 'package:travel_app/features/all_contributor_page/community_post_page.dart';
import 'package:travel_app/features/trip_booking_page/book_trip_page.dart';
import 'package:travel_app/features/user_contribution_page/contribution_page.dart';

class AppNavigation extends StatefulWidget {
  final String? userAccessToken;
  AppNavigation(this.userAccessToken);
  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  //* global scope - property
  static int currentPageIndex = 0;
  static List<int> loadingPages = [0];

  //* all icon in default state
  final List<IconData> defaultIcons = [
    Icons.home_outlined,
    Icons.add_to_photos_outlined,
    Icons.person_2_sharp,
    Icons.add_location_alt_outlined,
  ];
  //* all icon in active state
  final List<IconData> activeIcons = [
    Icons.home,
    Icons.add_to_photos,
    Icons.person_2,
    Icons.add_location_alt,
  ];

  //* when user press the icon.
  void showCurrentPage(int currentIndex) {
    if (!loadingPages.contains(currentIndex)) {
      loadingPages.add(currentIndex);
    }
    setState(
      () {
        currentPageIndex = currentIndex;
      },
    );
  }

  //* custom widget pass the value showCurrentPage
  Widget buildNavigationItem(
    int currentIndex,
    //double width,
  ) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        showCurrentPage(currentIndex);
      },
      icon: Icon(
        currentPageIndex == currentIndex
            ? activeIcons[currentIndex]
            : defaultIcons[currentIndex],
        color: currentPageIndex == currentIndex ? Colors.teal : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //*functional scope

    List<Widget> screens = [
      HomePage(widget.userAccessToken),
      loadingPages.contains(1)
          ? CommunityPostPage(widget.userAccessToken)
          : Container(),
      loadingPages.contains(2) ? UserContributionPage() : Container(),
      loadingPages.contains(3) ? BookTripPage() : Container(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: currentPageIndex,
        children: screens,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        child: FloatingActionButton(
          heroTag: 'unique_fab_id_2',
          elevation: 1.5,
          onPressed: null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildNavigationItem(
                0,
              ),
              buildNavigationItem(
                1,
              ),
              buildNavigationItem(
                2,
              ),
              buildNavigationItem(
                3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
