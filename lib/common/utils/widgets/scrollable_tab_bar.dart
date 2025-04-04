// ignore: file_names
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class ScrollableTabBar extends StatefulWidget {
  final List<dynamic> menuOptions;
  final Function? onTap;
  final TabController? tabController;
  final int selectedIndex;
  final double tabHeight;
  final double tabHPadding;
  final double labelVPadding;
  final double adjustmentHeight;
  final double labelHPadding;
  final Color indicatorColor;
  final Color unselectedLabelColor;
  final Color labelColor;
  const ScrollableTabBar(
      {Key? key,
      required this.menuOptions,
      this.onTap,
      this.selectedIndex = 0,
      this.tabController,
      this.tabHeight = 25,
      this.tabHPadding = 5,
      this.labelVPadding = 0,
      this.adjustmentHeight = 1,
      this.indicatorColor = Colors.teal,
      this.unselectedLabelColor = Colors.black,
      this.labelColor = Colors.white,
      this.labelHPadding = 13})
      : super(key: key);

  @override
  State<ScrollableTabBar> createState() => _ScrollableTabBarState();
}

class _ScrollableTabBarState extends State<ScrollableTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.selectedIndex,
      length: widget.menuOptions.length,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TabBar(
            controller: widget.tabController,
            onTap: (int index) {
              if (widget.onTap == null) return;
              widget.onTap!(index);
            },
            isScrollable: true,
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.zero,
            indicatorWeight: 0,
            indicator: RectangularIndicator(
              verticalPadding: 0,
              color: widget.indicatorColor,
              bottomLeftRadius: 8,
              bottomRightRadius: 8,
              topLeftRadius: 8,
              topRightRadius: 8,
            ),
            unselectedLabelColor: widget.unselectedLabelColor,
            labelColor: widget.labelColor,
            labelStyle: Theme.of(context).textTheme.headlineSmall,
            labelPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            tabs: [
              for (var items in widget.menuOptions)
                Tab(
                  iconMargin: EdgeInsets.zero,
                  height: widget.tabHeight,
                  child: SizedBox(
                    width: 90,
                    child: Center(
                      child: Text(
                        items.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
