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

class _HomePageBodyState extends State<HomePageBody> {
  final TextEditingController searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Listen to text changes
    searchTextController.addListener(() {
      setState(() {
        searchTextController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: HomePageInnerNavigationButtonText.values.length,
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
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: StickySearchBar(
                searchTextController: searchTextController,
              ),
            ),
            if (searchTextController.text.isEmpty)
              SliverPersistentHeader(
                pinned: true,
                delegate: HomePageNavigationButton(),
              ),
          ];
        },
        body: Consumer<HomePageProvider>(
          builder: (context, homePageProvider, child) {
            bool isLoading = homePageProvider.isLoading;

            List<PublisherModel>? baseData =
                homePageProvider.filteredPublisherData ??
                    homePageProvider.allPublisherData;

            List<PublisherModel>? filteredData =
                homePageProvider.searchPublisherData;

            if (baseData == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            List<dynamic>? userWishlist = homePageProvider.userWishlist;

            if (searchTextController.text.isNotEmpty) {
              return DataGrid(
                isLoading: isLoading,
                allDestination: filteredData,
                userWishlist: userWishlist,
              );
            } else {
              return TabBarView(
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
