import 'package:flutter/material.dart';
import 'package:travel_app/features/home_page/interface/home_page.dart';
import '../../../user_contribution_page/contribution_page.dart';

class HomePageNavigation extends StatefulWidget {
  final String? userAccessToken;
  HomePageNavigation(this.userAccessToken);
  @override
  State<HomePageNavigation> createState() => _HomePageNavigationState();
}

class _HomePageNavigationState extends State<HomePageNavigation> {
  int currentPageIndex = 0;
  List<int> loadingPages = [0];

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

  //* custom widget
  Widget buildNavigationItem(
    IconData icon,
    int pageIndex,
    double width,
  ) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        showCurrentPage(pageIndex);
      },
      icon: Icon(
        icon,
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
      loadingPages.contains(1) ? UserContributionPage() : Container(),
      loadingPages.contains(2) ? Container() : Container(),
      loadingPages.contains(3) ? Container() : Container(),
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
                Icons.home,
                0,
                width,
              ),
              SizedBox(width: spacing),
              buildNavigationItem(
                Icons.add_to_photos_outlined,
                1,
                width,
              ),
              SizedBox(width: spacing),
              buildNavigationItem(
                Icons.notification_add_outlined,
                2,
                width,
              ),
              SizedBox(width: spacing),
              buildNavigationItem(
                Icons.settings_outlined,
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
