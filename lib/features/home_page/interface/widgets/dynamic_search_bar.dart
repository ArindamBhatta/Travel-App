import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/features/home_page/interface/widgets/filter_Page.dart';
import 'package:travel_app/features/home_page/module/data/home_page_provider.dart';

class DynamicSearchBar extends StatefulWidget {
  final SearchController searchController;
  final TextEditingController textController;

  const DynamicSearchBar({
    required this.searchController,
    required this.textController,
  });

  @override
  _DynamicSearchBarState createState() => _DynamicSearchBarState();
}

class _DynamicSearchBarState extends State<DynamicSearchBar> {
  late Timer _timer;
  int _hintIndex = 0;
  List<String> searchHistory = [];

  // List of hint texts
  final List<String> hintTexts = [
    "Find your next adventure ✈️",
    "Seek new experiences ♨️ ",
    "Embrace the unknown 🌊"
  ];

  @override
  void initState() {
    super.initState();
    // Change hint text every 2 seconds
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        _hintIndex = (_hintIndex + 1) % hintTexts.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel timer to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomePageProvider provider =
        Provider.of<HomePageProvider>(context, listen: false);

    return SearchAnchor(
      isFullScreen: true,
      searchController: widget.searchController,
      viewHintText: 'Search........',
      headerHintStyle: TextStyle(color: Colors.blueGrey),
      viewSurfaceTintColor: Colors.transparent,
      viewBackgroundColor: Colors.white.withAlpha(200),
      keyboardType: TextInputType.name,
      dividerColor: Colors.black,
      viewTrailing: [
        IconButton(
          onPressed: () {
            if (widget.searchController.text.isNotEmpty) {
              searchHistory.add(widget.searchController.text);
              searchHistory = searchHistory.reversed.toSet().toList();
            }
            widget.textController.text = widget.searchController.text;
            provider.filterDataWhenSearch(widget.searchController.text);
            widget.searchController.closeView(widget.searchController.text);
          },
          icon: Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {
            widget.searchController.clear();
            widget.textController.clear();
            widget.searchController.closeView('');
            provider.filterDataWhenSearch('');
          },
          icon: Icon(Icons.clear),
        ),
      ],
      viewOnChanged: (value) {
        widget.textController.text = value;
        provider.filterDataWhenSearch(value);
      },
      viewOnSubmitted: (value) {
        if (value.isNotEmpty) {
          searchHistory.add(value);
          searchHistory = searchHistory.reversed.toSet().toList();
        }
        widget.textController.text = value;
        provider.filterDataWhenSearch(value);
        widget.searchController.closeView(value);
        FocusScope.of(context).unfocus();
      },
      builder: (context, searchTextController) {
        return SearchBar(
          keyboardType: TextInputType.none,

          controller: widget.textController,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.search),
          ),
          trailing: [
            if (widget.textController.text.isNotEmpty)
              IconButton(
                icon: Icon(Icons.clear, color: Colors.red),
                onPressed: () {
                  setState(() {
                    searchTextController.clear();
                    widget.textController.clear();
                    provider.filterDataWhenSearch('');
                    FocusScope.of(context).unfocus();
                  });
                },
              )
            else if (provider.userSelectedContinents.isEmpty ||
                provider.userSelectedTags.isEmpty)
              IconButton(
                icon: Icon(Icons.tune_outlined),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: false,
                    builder: (BuildContext context) {
                      return FilterPage();
                    },
                  );
                },
              )
            else
              IconButton(
                onPressed: () {
                  provider.removeFilterOnTap();
                },
                icon: Icon(
                  Icons.cancel_outlined,
                  color: Colors.red,
                ),
              )
          ],
          hintText: hintTexts[_hintIndex], // Dynamic hint text
          hintStyle: WidgetStatePropertyAll(
            TextStyle(color: Colors.grey),
          ),
          onTap: () {
            searchTextController.openView();
          },

          onChanged: (value) {
            searchTextController.text = value;
            provider.filterDataWhenSearch(value);
          },
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
        );
      },
      suggestionsBuilder: (BuildContext context, searchTextController) {
        if (searchHistory.isEmpty) {
          return [
            Container(
              padding: EdgeInsets.all(12),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Suggested categories',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: 44.0,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: Icon(
                            Icons.kayaking_outlined,
                            size: 24,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: Icon(
                            Icons.restaurant,
                            size: 24,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: Icon(
                            Icons.landscape_outlined,
                            size: 24,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: Icon(
                            Icons.agriculture_outlined,
                            size: 24,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: Icon(
                            Icons.landscape_outlined,
                            size: 24,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: Icon(
                            Icons.landscape_outlined,
                            size: 24,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: Icon(
                            Icons.landscape_outlined,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ];
        }
        String query = widget.searchController.text.toLowerCase();

        List<String> prevSearchData = searchHistory.where((item) {
          return item.toLowerCase().contains(query);
        }).toList();

        return [
          Container(
            constraints: BoxConstraints(maxHeight: 300),
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  prevSearchData.length,
                  (index) {
                    String item = prevSearchData[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      child: ListTile(
                        leading: Icon(Icons.history),
                        title: Text(item),
                        selected: item == searchTextController.text,
                        onTap: () {
                          searchTextController.closeView(item);
                          widget.textController.text = item;
                          provider.filterDataWhenSearch(item);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ];
      },
    );
  }
}
