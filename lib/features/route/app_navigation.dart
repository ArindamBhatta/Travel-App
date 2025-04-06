import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:travel_app/features/home/interface/home_page.dart';
import 'package:travel_app/features/contributor/community_post_page.dart';
import 'package:travel_app/features/trip_booking_page/book_trip_page.dart';
import 'package:travel_app/features/user_contribution_page/user_contribution_page.dart';

const Color bottomNavBgColor = Color.fromARGB(255, 240, 240, 240);

class AppNavigation extends StatefulWidget {
  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  static int currentPageIndex = 0;
  bool _isNavBarVisible = true;

  final List<String> pathOfIcons = [
    'assets/icons/home.png',
    'assets/icons/contributor.png',
    'assets/icons/search.png',
    'assets/icons/chat.png',
  ];

  // Wrap each screen with a scroll listener
  late final List<Widget> screens = [
    _wrapWithScrollListener(HomePage()),
    _wrapWithScrollListener(CommunityPostPage()),
    _wrapWithScrollListener(BookTripPage()),
    _wrapWithScrollListener(BookTripPage()),
  ];

  Widget _wrapWithScrollListener(Widget child) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is UserScrollNotification) {
          final direction = notification.direction;
          if (direction == ScrollDirection.reverse && _isNavBarVisible) {
            setState(() => _isNavBarVisible = false);
          } else if (direction == ScrollDirection.forward &&
              !_isNavBarVisible) {
            setState(() => _isNavBarVisible = true);
          }
        }
        return false;
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBody: false,
        body: screens[currentPageIndex],

        // Bottom Navigation Bar
        bottomNavigationBar: AnimatedSize(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: _isNavBarVisible
              ? Theme(
                  data: Theme.of(context).copyWith(
                    iconTheme: IconThemeData(color: Colors.white),
                  ),
                  child: CurvedNavigationBar(
                    backgroundColor: Colors.transparent,
                    color: Colors.tealAccent,
                    buttonBackgroundColor: Colors.teal,
                    height: 60,
                    index: currentPageIndex,
                    items: pathOfIcons.map((iconPath) {
                      return Padding(
                        padding: EdgeInsets.all(8),
                        child: Image.asset(
                          iconPath,
                          width: 20,
                          height: 20,
                          color: Colors.white,
                        ),
                      );
                    }).toList(),
                    //
                    onTap: (int index) {
                      setState(() {
                        currentPageIndex = index;
                      });
                    },
                  ),
                )
              : SizedBox.shrink(),
        ),
      ),
    );
  }
}
