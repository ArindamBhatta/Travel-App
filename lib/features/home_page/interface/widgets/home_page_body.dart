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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomePageProvider()..showPublisherData(),
      /* 
       create: (context) => HomePageProvider() This line create a new context of HomePageProvider
       ..showPublisherData() This part immediately calls the showPublisherData() method on the newly created HomePageProvider instance. This means that when the provider is created, it will automatically fetch and load the publisher data.       
      */

// child: This property specifies the widget tree that will have access to the data provided by HomePageProvider.
      child: Consumer<HomePageProvider>(
        /* 
         Consumer<HomePageProvider>
          builder: This is where you define how to build the UI based on the data provided by HomePageProvider.
          (context, homePageProvider, child)
            context: The build context of the widget.
              homePageProvider: An instance of the HomePageProvider class, allowing you to access its properties and methods.
            child: The widget that was passed as a child to ChangeNotifierProvider. This is often used to pass down widgets that don't need to rebuild when the provider's state changes.
        */
        builder: (context, homePageProvider, child) {
          bool isLoading = homePageProvider.isLoading;
          List<PublisherModel>? filteredPublisherData =
              homePageProvider.allPublisherData; // Use the filtered data.
          List<String>? allPublisherDataKey =
              homePageProvider.allPublisherDataKey;
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
              if (isLoading)
                const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else if ((filteredPublisherData == null &&
                      allPublisherDataKey == null) ||
                  (filteredPublisherData!.isEmpty &&
                      allPublisherDataKey!.isEmpty))
                const SliverFillRemaining(
                  child: Center(
                    child: Text('No data available'),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        PublisherModel publisherSingleData =
                            filteredPublisherData[index];

                        String publisherDataKey = allPublisherDataKey![index];

                        return CardToDetailsPage(
                          destination: publisherSingleData,
                          destinationKey: publisherDataKey,
                          userWishlist: userWishlist,
                        );
                      },
                      childCount: filteredPublisherData.length,
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
