import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/features/home_page/interface/widgets/data_grid.dart';
import 'package:travel_app/features/home_page/interface/widgets/home_page_app_bar.dart';
import 'package:travel_app/features/home_page/interface/widgets/home_page_navigation_button.dart';
import 'package:travel_app/features/home_page/interface/widgets/sticky_search_bar.dart';
import 'package:travel_app/features/home_page/interface/widgets/user_wish_list.dart';
import 'package:travel_app/features/home_page/module/data/home_page_provider.dart';
import 'package:travel_app/features/home_page/module/model/publisher_model.dart';

class HomePageBody extends StatelessWidget {
  final Map<String, dynamic>? userLoginData;

  HomePageBody({
    super.key,
    required this.userLoginData,
  });

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
                  userInfo: userLoginData,
                  headingText: 'Wanderly',
                  onAvatarTap: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: StickySearchBar(),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: HomePageNavigationButton(),
            ),
          ];
        },
        body: Consumer<HomePageProvider>(
          builder: (context, homePageProvider, child) {
            bool isLoading = homePageProvider.isLoading;
            // if in case filterPublisherData is null then allPublisherData is shown
            List<PublisherModel>? displayPublisherData =
                homePageProvider.filteredPublisherData ??
                    homePageProvider.allPublisherData;

            List<dynamic>? userWishlist = homePageProvider.userWishlist;

            return TabBarView(
              children: [
                DataGrid(
                  isLoading: isLoading,
                  allDestination: displayPublisherData,
                  userWishlist: userWishlist,
                ),
                UserWishList(
                  userWishlist: userWishlist,
                ),
                Container(
                  child: Center(
                    child: Text('Coming Soon!'),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text('Coming Soon!'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
