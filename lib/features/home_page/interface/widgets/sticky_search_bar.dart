import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/features/home_page/interface/widgets/filter_Page.dart';
import 'package:travel_app/features/home_page/module/data/home_page_provider.dart';

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
    HomePageProvider provider =
        Provider.of<HomePageProvider>(context, listen: false);

    return Container(
      margin: EdgeInsets.zero,
      height: maxExtent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StatefulBuilder(
          builder: (context, setState) {
            return SearchAnchor(
              isFullScreen: false,
              searchController: searchController,
              viewHintText: 'Search.....',
              viewTrailing: [
                IconButton(
                  onPressed: () {
                    provider.searchHistory.add(searchController.text);
                    provider.searchHistory =
                        provider.searchHistory.reversed.toSet().toList();
                    textController.text = searchController.text; // Sync Text
                    provider.filterDataWhenSearch(
                        searchController.text); // Filter results
                    searchController.closeView(searchController.text);
                  },
                  icon: Icon(Icons.search),
                ),
                IconButton(
                  onPressed: () {
                    searchController.clear();
                    textController.clear(); // Sync clearing
                    provider.filterDataWhenSearch('');
                  },
                  icon: Icon(Icons.clear),
                )
              ],
              keyboardType: TextInputType.name,
              dividerColor: Colors.black,
              viewOnChanged: (value) {
                textController.text = value; // Sync SearchBar
                provider.filterDataWhenSearch(value);
              },
              viewOnSubmitted: (value) {
                provider.searchHistory.add(value);
                provider.searchHistory =
                    provider.searchHistory.reversed.toSet().toList();
                textController.text = value; // Sync Text
                provider.filterDataWhenSearch(value); // Filter results
                searchController.closeView(value);
                FocusScope.of(context).unfocus();
              },
              builder: (context, searchTextController) {
                return SearchBar(
                  controller:
                      textController, // Use TextEditingController for syncing
                  leading: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                    ),
                  ),
                  trailing: [
                    if (textController.text.isNotEmpty)
                      IconButton(
                        icon: Icon(Icons.clear, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            searchTextController.clear();
                            textController.clear(); // Sync clear
                            provider.filterDataWhenSearch('');
                            FocusScope.of(context).unfocus(); // Hide keyboard
                          });
                        },
                      )
                    else
                      IconButton(
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
                  ],
                  hintText: 'Search for places...',
                  hintStyle: WidgetStatePropertyAll(
                    TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    searchTextController.openView();
                  },
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  onChanged: (value) {
                    searchTextController.text = value; // Sync with SearchAnchor
                    provider.filterDataWhenSearch(value);
                  },
                );
              },
              suggestionsBuilder: (BuildContext context, searchTextController) {
                List<String> prevSearchData = provider.searchHistory;
                return [
                  Wrap(
                    children: List.generate(prevSearchData.length, (index) {
                      String item = prevSearchData[index];
                      return Padding(
                        padding: EdgeInsets.only(left: 4.0, right: 4.0),
                        child: ListTile(
                          leading: Icon(Icons.history),
                          title: Text(item),
                          selected: item == searchTextController.text,
                          onTap: () {
                            searchTextController.closeView(item);
                            textController.text = item; // Sync Text
                            provider
                                .filterDataWhenSearch(item); // Trigger search
                          },
                        ),
                      );
                    }),
                  )
                ];
              },
            );
          },
        ),
      ),
    );
  }
}
