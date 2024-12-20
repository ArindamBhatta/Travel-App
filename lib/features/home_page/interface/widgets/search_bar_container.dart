import 'package:flutter/material.dart';

class SearchBarContainer extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _SearchBar();
  }

  @override
  double get maxExtent => 90.0;
  @override
  double get minExtent => 75.0;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class _SearchBar extends StatefulWidget {
  const _SearchBar();

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    Color contextColor = Theme.of(context).scaffoldBackgroundColor;
    return Container(
      margin: EdgeInsets.zero,
      color: contextColor,
      height: 90,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: contextColor,
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
