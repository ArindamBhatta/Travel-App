import 'package:flutter/material.dart';
import 'package:travel_app/features/home_page/interface/home_page.dart';
import 'package:travel_app/features/all_contributor_page/all_contribution_page.dart';
import 'package:travel_app/features/trip_booking_page/book_trip_page.dart';
import '../../../user_contribution_page/contribution_page.dart';

class HomePageNavigation extends StatefulWidget {
  final String? userAccessToken;
  HomePageNavigation(this.userAccessToken);
  @override
  State<HomePageNavigation> createState() => _HomePageNavigationState();
}

class _HomePageNavigationState extends State<HomePageNavigation> {
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
    double width,
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
    double width = MediaQuery.of(context).size.width;
    double spacing = width * 0.1;

    List<Widget> screens = [
      HomePage(widget.userAccessToken),
      loadingPages.contains(1) ? NotificationPage() : Container(),
      loadingPages.contains(2) ? UserContributionPage() : Container(),
      loadingPages.contains(3) ? BookTripPage() : Container(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: currentPageIndex,
        children: screens,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: FloatingActionButton.extended(
          heroTag: 'unique_fab_id_2',
          elevation: 1,
          onPressed: null,
          label: Row(
            children: [
              buildNavigationItem(
                0,
                width,
              ),
              SizedBox(width: spacing),
              buildNavigationItem(
                1,
                width,
              ),
              SizedBox(width: spacing),
              buildNavigationItem(
                2,
                width,
              ),
              SizedBox(width: spacing),
              buildNavigationItem(
                3,
                width,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
