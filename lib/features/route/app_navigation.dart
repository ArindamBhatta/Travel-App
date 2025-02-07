import 'package:flutter/material.dart';
import 'package:travel_app/features/home_page/interface/home_page.dart';
import 'package:travel_app/features/all_contributor_page/community_post_page.dart';
import 'package:travel_app/features/introduction_page/model/google_login_provider.dart';
import 'package:travel_app/features/trip_booking_page/book_trip_page.dart';
import 'package:travel_app/features/user_contribution_page/user_contribution_page.dart';

const Color bottomNavBgColor = Color.fromARGB(255, 240, 240, 240);

class AppNavigation extends StatefulWidget {
  final String? userAccessToken;
  AppNavigation(this.userAccessToken);
  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  //* global scope - property
  static int currentPageIndex = 0;

  //* all icon in default state
  final List<IconData> defaultIcons = [
    Icons.home_outlined,
    Icons.add_to_photos_outlined,
    Icons.person_2_sharp,
    Icons.add_location_alt_outlined,
  ];

  List<Widget> screens = [
    HomePage(),
    CommunityPostPage(GoogleLoginProvider.accessToken),
    UserContributionPage(),
    BookTripPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentPageIndex],
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 56,
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: bottomNavBgColor,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 128, 123, 123),
                offset: Offset(0, 20),
                blurRadius: 10,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Center items
            children: List.generate(
              defaultIcons.length,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    currentPageIndex = index; // Update selected tab
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  height: 46,
                  width: 46,
                  decoration: BoxDecoration(
                    color: currentPageIndex == index
                        ? const Color.fromARGB(255, 159, 157, 157)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      defaultIcons[index],
                      color: currentPageIndex == index
                          ? Colors.blue
                          : Colors.grey.shade400,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
