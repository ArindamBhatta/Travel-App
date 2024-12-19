import 'package:flutter/material.dart';
import 'package:travel_app/features/home_page/interface/widgets/text_button_navigation.dart';

class SearchBarContainer extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: const _SearchBar(),
    );
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
  @override
  Widget build(BuildContext context) {
    Color contextColor = Theme.of(context).scaffoldBackgroundColor;
    List<String> textButtons = ['All', 'Popular', 'Recommended', 'WishListed'];
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(16),
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal[400]!),
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black),
                borderRadius: BorderRadius.circular(12),
              ),
              fillColor: contextColor,
              labelText: 'Search',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: const Icon(Icons.tune_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
        ),
        SizedBox(
          height: 50, // Adjust height for horizontal scrolling buttons
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  for (int index = 0; index < textButtons.length; index++)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextButtonNavigation(
                        id: index,
                        buttonText: textButtons[index],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
