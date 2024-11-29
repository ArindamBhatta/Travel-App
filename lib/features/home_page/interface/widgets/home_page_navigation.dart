import 'package:flutter/material.dart';
import 'package:travel_app/features/details_page/details_page.dart';
import 'package:travel_app/features/home_page/interface/home_page.dart';
import '../../../user_contribution_page/user_contribution_page.dart';

class HomePageNavigation extends StatefulWidget {
  @override
  State<HomePageNavigation> createState() => _HomePageNavigationState();
}

class _HomePageNavigationState extends State<HomePageNavigation> {
  int currentPageIndex = 0; //* index Stack needs this current page
  List<int> loadingPages = [0]; //* push the content on tap a navigation.

  //* when user press the icon.
  void showCurrentPage(int onTapPageIndex) {
    // *if this condition is false
    if (!loadingPages.contains(onTapPageIndex)) {
      loadingPages.add(onTapPageIndex);
    }
    setState(
      () {
        currentPageIndex = onTapPageIndex;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    List<Widget> screens = [
      HomePage(),
      loadingPages.contains(1) ? UserContributionPage() : Container(),
      loadingPages.contains(2) ? DetailsPage(id: 102) : Container(),
      loadingPages.contains(3) ? DetailsPage(id: 103) : Container(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: currentPageIndex,
        children: screens,
      ),

      ///////
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton.extended(
          heroTag: 'unique_fab_id_2',
          elevation: 1,
          backgroundColor: Colors.white70,
          onPressed: null,
          label: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildNavigationItem(
                Icons.home,
                0,
                width,
                Colors.black,
              ),
              SizedBox(width: width * 0.06),
              buildNavigationItem(
                Icons.add_to_photos_outlined,
                1,
                width,
                Colors.black,
              ),
              SizedBox(width: width * 0.06),
              buildNavigationItem(
                Icons.notification_add_outlined,
                2,
                width,
                Colors.black,
              ),
              SizedBox(width: width * 0.06),
              buildNavigationItem(
                Icons.settings_outlined,
                3,
                width,
                Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavigationItem(
    IconData icon,
    int pageIndex,
    double width,
    Color color,
  ) {
    return TextButton(
      onPressed: () {
        showCurrentPage(pageIndex);
      },
      child: Icon(
        icon,
        color: (currentPageIndex == pageIndex) ? Colors.blue : color,
      ),
    );
  }
}
