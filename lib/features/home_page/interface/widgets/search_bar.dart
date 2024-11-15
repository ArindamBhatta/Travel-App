import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class SearchBarContainer extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return OpenContainer(
      closedElevation: 0,
      openElevation: 0,
      openColor: Colors.red,
      transitionType: ContainerTransitionType.fadeThrough,
      //* when it's closed
      closedBuilder: (context, openContainer) => GestureDetector(
        onTap: openContainer, // Opens the container when tapped
        child: Container(
          alignment: Alignment.center,
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Icon(Icons.search, size: 30, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  'Search', // Placeholder text
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                Spacer(),
                Icon(Icons.tune_outlined, size: 20, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
      //* when it's open
      openBuilder: (context, closeContainer) => Scaffold(
        body: Column(
          children: [
            Container(
              color: Colors.transparent,
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                autofocus:
                    true, // Focus the TextField and open the keyboard here
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal[400]!),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  fillColor: Colors.white,
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search, size: 30),
                  suffixIcon: Icon(Icons.tune_outlined, size: 20),
                ),
              ),
            ),
          ],
        ),
      ),
      transitionDuration: Duration(milliseconds: 800),
    );
  }

  @override
  double get maxExtent => 90.0;

  @override
  double get minExtent => 60.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
