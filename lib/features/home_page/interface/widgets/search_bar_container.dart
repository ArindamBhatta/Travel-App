import 'package:flutter/material.dart';
import 'package:travel_app/common/widgets/custom_text_form_field.dart';

class SearchBarContainer extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _SearchBar();
  }

  @override
  double get maxExtent => 120.0;
  @override
  double get minExtent => 85.0;
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
    return Container(
      height: 120,
      color: Colors.white30,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomTextFormField(
          labelText: 'Search',
          prefixIcon: Icons.search,
          suffixIcon: Icons.tune_outlined,
          textBoxHeight: 20.0,
        ),
      ),
    );
  }
}
