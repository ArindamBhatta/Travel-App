import 'package:flutter/material.dart';
import 'package:travel_app/common/utils/widgets/scrollable_tab_bar.dart';
import 'package:travel_app/features/home/module/data/home_page_provider.dart';

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
      height: 80,
      color: Colors.white,
      margin: EdgeInsets.zero,
      child: ScrollableTabBar(
        menuOptions: menuOptions,
        tabController: tabController,
        tabHeight: 24,
        tabHPadding: 5,
        selectedIndex: 0,
        adjustmentHeight: 0,
        indicatorColor: Colors.teal,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        labelHPadding: 10,
        onTap: onTap,
      ),
    );
  }
}
