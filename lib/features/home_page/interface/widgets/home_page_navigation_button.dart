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
  double get maxExtent => 40;
  @override
  double get minExtent => 30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  Widget tabBarButton(bool isSelected, String buttonText) {
    return Container(
      height: maxExtent,
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: (isSelected ? Colors.teal[500] : Colors.white),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            buttonText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: (isSelected ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 90,
      color: Colors.white,
      margin: EdgeInsets.zero,
      child: SizedBox(
        height: 26,
        child: TabBar(
          controller: tabController,
          onTap: (int index) {
            if (onTap != null) {
              onTap!(index);
            }
          },
          isScrollable: true,
          labelPadding: EdgeInsets.symmetric(horizontal: 2),
          dividerColor: Theme.of(context).scaffoldBackgroundColor,
          indicator: RectangularIndicator(),
          tabs: [
            Tab(
              child: Builder(
                builder: (context) {
                  final TabController controller =
                      DefaultTabController.of(context);
                  return AnimatedBuilder(
                    animation: controller,
                    builder: (context, AboutDialog) {
                      final isSelected = controller.index == 0;
                      return tabBarButton(
                        isSelected,
                        MainMenuOptions.All.name,
                      );
                    },
                  );
                },
              ),
            ),
            Tab(
              iconMargin: null,
              child: Builder(
                builder: (context) {
                  final TabController controller =
                      DefaultTabController.of(context);
                  return AnimatedBuilder(
                    animation: controller,
                    builder: (context, _) {
                      final isSelected = controller.index == 1;
                      return tabBarButton(
                        isSelected,
                        MainMenuOptions.WishListed.name,
                      );
                    },
                  );
                },
              ),
            ),
            Tab(
              child: Builder(
                builder: (context) {
                  final TabController controller =
                      DefaultTabController.of(context);
                  return AnimatedBuilder(
                    animation: controller,
                    builder: (context, _) {
                      final isSelected = controller.index == 2;
                      return tabBarButton(
                        isSelected,
                        MainMenuOptions.MostWished.name,
                      );
                    },
                  );
                },
              ),
            ),
            Tab(
              child: Builder(
                builder: (context) {
                  final TabController controller =
                      DefaultTabController.of(context);
                  return AnimatedBuilder(
                    animation: controller,
                    builder: (context, _) {
                      final isSelected = controller.index == 3;
                      return tabBarButton(
                        isSelected,
                        MainMenuOptions.MostViewed.name,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
