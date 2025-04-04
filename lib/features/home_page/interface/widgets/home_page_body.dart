import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/features/home_page/interface/widgets/data_grid.dart';
import 'package:travel_app/features/home_page/interface/widgets/home_page_app_bar.dart';
import 'package:travel_app/features/home_page/interface/widgets/home_page_navigation_button.dart';
import 'package:travel_app/features/home_page/interface/widgets/most_visited_page.dart';
import 'package:travel_app/features/home_page/interface/widgets/most_wishlisted.dart';
import 'package:travel_app/features/home_page/interface/widgets/sticky_search_bar.dart';
import 'package:travel_app/features/home_page/interface/widgets/user_wish_list.dart';
import 'package:travel_app/features/home_page/module/data/home_page_provider.dart';
import 'package:travel_app/features/home_page/module/model/publisher_model.dart';

class HomePageBody extends StatefulWidget {
  final Map<String, dynamic>? userLoginData;

  HomePageBody({required this.userLoginData});

  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody>
    with SingleTickerProviderStateMixin {
  SearchController searchController = SearchController();
  TextEditingController textController = TextEditingController();

  late TabController tabController = TabController(
      initialIndex: 0, length: MainMenuOptions.values.length, vsync: this);

  @override
  void initState() {
    super.initState();

    // Listen to text changes
    searchController.addListener(() {
      setState(() {
        searchController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //use Default tab controller to control the tabs
    return DefaultTabController(
      length: MainMenuOptions.values.length,
      initialIndex: 0,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              expandedHeight: 75.0,
              flexibleSpace: FlexibleSpaceBar(
                background: HomePageAppBar(
                  userInfo: widget.userLoginData,
                  headingText: 'Wanderly',
                  onAvatarTap: () => Scaffold.of(context).openDrawer(),
                  onNotificationTap: () {},
                ),
              ),
            ),
            //
            SliverPersistentHeader(
              pinned: true,
              delegate: StickySearchBar(
                searchController: searchController,
                textController: textController,
              ),
            ),

            //
            if (searchController.text.isEmpty)
              SliverPersistentHeader(
                pinned: true,
                delegate: HomePageNavigationButton(
                  menuOptions: MainMenuOptions.values,
                  tabController: tabController,
                ),
              ),
          ];
        },
        body: Consumer<HomePageProvider>(
          builder: (context, homePageProvider, child) {
            bool isLoading = homePageProvider.isLoading;

            List<PublisherModel>? baseData =
                homePageProvider.filteredDataBasedOnTap ??
                    homePageProvider.allPublisherData;

            List<PublisherModel>? filteredData =
                homePageProvider.filterDataBasedOnSearch;

            if (baseData == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            ///

            List<dynamic>? userWishlist = homePageProvider.userWishlist;

            if (searchController.text.isNotEmpty) {
              return DataGrid(
                isLoading: isLoading,
                allDestination: filteredData,
                userWishlist: userWishlist,
              );
            } else {
              return TabBarView(
                controller: tabController,
                children: [
                  DataGrid(
                    isLoading: isLoading,
                    allDestination: baseData,
                    userWishlist: userWishlist,
                  ),
                  UserWishList(
                    allDestination: baseData,
                    userWishlist: userWishlist,
                  ),
                  MostWishListed(
                    allDestination: baseData,
                    userWishlist: userWishlist,
                  ),
                  MostVisitedPage(
                    allDestination: baseData,
                    userWishlist: userWishlist,
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
