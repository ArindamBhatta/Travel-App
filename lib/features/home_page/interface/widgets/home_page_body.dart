import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/features/home_page/interface/widgets/card_to_details_page.dart';
import 'package:travel_app/features/home_page/interface/widgets/sticky_navigation_button.dart';
import 'package:travel_app/features/home_page/module/data/home_page_provider.dart';
import 'package:travel_app/features/home_page/module/model/publisher_model.dart';
import 'sticky_search_bar.dart';
import 'home_page_app_bar.dart';

class HomePageBody extends StatelessWidget {
  final Map<String, dynamic>? userLoginData;

  HomePageBody({
    super.key,
    required this.userLoginData,
  });

  final HomePageProvider hpp = HomePageProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: context.read<HomePageProvider>()..showPublisherData(),
      child: Consumer<HomePageProvider>(
        builder: (context, homePageProvider, child) {
          bool isLoading = homePageProvider.isLoading;

          List<PublisherModel>? allPublisherData =
              homePageProvider.allPublisherData;

          List<String>? allPublisherDataKey =
              homePageProvider.allPublisherDataKey;
          // user wishlist data.
          List<dynamic>? userWishlist = homePageProvider.userWishlist;

          return CustomScrollView(
            slivers: [
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
                delegate: StickyNavigationButton(),
              ),
              if (isLoading == true)
                const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else if ((allPublisherData == null &&
                      allPublisherDataKey == null) ||
                  (allPublisherData!.isEmpty && allPublisherDataKey!.isEmpty))
                const SliverFillRemaining(
                  child: Center(
                    child: Text('No data available'),
                  ),
                )
              else if (allPublisherData.length != allPublisherDataKey?.length)
                const SliverFillRemaining(
                  child: Center(
                    child: Text('Match every document keys'),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        PublisherModel publisherSingleData =
                            allPublisherData[index];

                        String publisherDataKey = allPublisherDataKey![index];

                        return CardToDetailsPage(
                          destination: publisherSingleData,
                          destinationKey: publisherDataKey,
                          userWishlist: userWishlist,
                        );
                      },
                      childCount: allPublisherData.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.85,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
