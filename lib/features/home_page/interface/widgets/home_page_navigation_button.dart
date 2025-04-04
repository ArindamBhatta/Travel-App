import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:travel_app/features/home_page/module/data/home_page_provider.dart';

class HomePageNavigationButton extends SliverPersistentHeaderDelegate {
  final List<MainMenuOptions> menuOptions;
  final TabController? tabController;
  final Function? onTap;

  HomePageNavigationButton({
    required this.menuOptions,
    required this.tabController,
    this.onTap,
  });

  @override
  double get maxExtent => 45;

  @override
  double get minExtent => 35;

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
      child: SizedBox(
        height: 40,
        child: TabBar(
          controller: tabController,
          onTap: (int index) {
            if (onTap == null) return;
            onTap!(index);
          },
          isScrollable: false,
          labelPadding: EdgeInsets.symmetric(horizontal: 8), // Adds spacing
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.zero,
          indicatorWeight: 0,
          dividerColor: Theme.of(context).scaffoldBackgroundColor,
          indicator: RectangularIndicator(
            color: Colors.teal,
            bottomLeftRadius: 8,
            bottomRightRadius: 8,
            topLeftRadius: 8,
            topRightRadius: 8,
          ),
          tabs: menuOptions.map((option) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: SizedBox(
                width: 90,
                child: Tab(text: option.name),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
