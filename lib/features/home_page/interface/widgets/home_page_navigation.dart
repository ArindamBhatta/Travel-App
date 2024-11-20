import 'package:flutter/material.dart';
import 'package:travel_app/features/details_page/details_page.dart';
import 'package:travel_app/features/home_page/interface/home_page.dart';

class HomePageNavigation extends StatefulWidget {
  @override
  State<HomePageNavigation> createState() => _HomePageNavigationState();
}

class _HomePageNavigationState extends State<HomePageNavigation> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: currentPageIndex,
        children: [
          HomePage(),
          DetailsPage(id: 101),
          DetailsPage(id: 102),
          DetailsPage(id: 103),
        ],
      ),
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
        setState(() {
          currentPageIndex = pageIndex;
        });
      },
      child: Icon(
        icon,
        color: currentPageIndex == pageIndex ? Colors.blue : color,
      ),
    );
  }
}
