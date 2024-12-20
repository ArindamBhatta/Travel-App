import 'package:flutter/material.dart';
import 'package:travel_app/features/home_page/interface/widgets/text_button_navigation.dart';
import 'package:travel_app/features/home_page/module/data/home_page_provider.dart';

class StickyNavigationButton extends SliverPersistentHeaderDelegate {
  @override
  double get maxExtent => 60.0;

  @override
  double get minExtent => 60.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 90,
      color: Colors.white,
      margin: EdgeInsets.zero,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            children: [
              for (int index = 0; index < Continent.values.length; index++)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextButtonNavigation(
                    id: index,
                    continent: Continent.values[index],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
