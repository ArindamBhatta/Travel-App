import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/features/home_page/interface/widgets/filter_Page.dart';
import 'package:travel_app/features/home_page/module/data/home_page_provider.dart';

class StickySearchBar extends SliverPersistentHeaderDelegate {
  final TextEditingController searchTextController;

  StickySearchBar({
    required this.searchTextController,
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
      color: Colors.white,
      height: maxExtent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),

        // use a Stateful builder change the state
        child: StatefulBuilder(
          builder: (context, setState) {
            return TextFormField(
              controller: searchTextController,
              keyboardType: TextInputType.text,
              autocorrect: true,
              autovalidateMode: AutovalidateMode.always,

              //decoration
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.white,
                labelText: 'Search',
                hintText: 'Mountains',
                hintStyle: TextStyle(
                  color: Colors.teal,
                  fontSize: 14,
                ),
                prefixIcon: Icon(Icons.search),
                suffixIcon: searchTextController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            searchTextController.clear();
                          });
                        },
                      )
                    : IconButton(
                        icon: Icon(Icons.tune_outlined),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return FilterPage();
                            },
                          );
                        },
                      ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              // if anything is change
              onChanged: (value) {
                setState(() {
                  searchTextController.text.isNotEmpty;
                });
                context
                    .read<HomePageProvider>()
                    .filterDataWhenSearch(searchTextController.text);
              },
            );
          },
        ),
      ),
    );
  }
}
