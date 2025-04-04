import 'package:flutter/material.dart';
import 'package:travel_app/features/home/interface/widgets/dynamic_search_bar.dart';

class StickySearchBar extends SliverPersistentHeaderDelegate {
  final SearchController searchController;
  final TextEditingController textController;

  StickySearchBar({
    required this.searchController,
    required this.textController,
  });

  @override
  double get maxExtent => 90.0;

  @override
  double get minExtent => 75.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      margin: EdgeInsets.zero,
      height: maxExtent,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DynamicSearchBar(
          searchController: searchController,
          textController: textController,
        ),
      ),
    );
  }
}
