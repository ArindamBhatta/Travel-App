import 'package:flutter/material.dart';

class StickySearchBar extends SliverPersistentHeaderDelegate {
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
      color: Colors.white,
      height: 90,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: Colors.white,
            labelText: 'Search',
            prefixIcon: Icon(Icons.search),
            suffixIcon: Icon(Icons.tune_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
      ),
    );
  }
}
