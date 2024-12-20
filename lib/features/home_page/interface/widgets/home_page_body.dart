import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/features/home_page/interface/widgets/publisher_card.dart';
import 'package:travel_app/features/home_page/module/data/home_page_provider.dart';
import 'search_bar_container.dart';
import 'home_page_app_bar.dart';
import 'text_button_navigation.dart';

class HomePageBody extends StatelessWidget {
  final Map<String, dynamic>? userLoginData;

  const HomePageBody({
    super.key,
    required this.userLoginData,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          expandedHeight: 75.0,
          //* giving the flexible space title and background is their
          flexibleSpace: FlexibleSpaceBar(
            background: HomePageAppBar(
              userInfo: userLoginData,
              headingText: 'Wanderly',
              onAvatarTap: () =>
                  Scaffold.of(context).openDrawer(), //* Open the drawer
            ),
          ),
        ),
        //* make the search bar sticky
        SliverPersistentHeader(
          pinned: true,
          delegate: SearchBarContainer(),
        ),
        //* make the horizontal list sticky
        SliverPersistentHeader(
          pinned: true,
          delegate: HorizontalScrollViewDelegate(),
        ),
        //*
        FutureBuilder<List<Map<String, dynamic>>>(
          future: context.read<HomePageProvider>().fetchPublisherData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SliverToBoxAdapter(
                child: Container(
                  height: 500,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      color: Colors.green,
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return SliverToBoxAdapter(
                child: Text('Some error is happen'),
              );
            } else if (snapshot.data!.isEmpty) {
              return SliverToBoxAdapter(
                child: Text('something happen'),
              );
            } else if (snapshot.hasData) {
              String continent =
                  context.watch<HomePageProvider>().currentContinent.name;
              List<Map<String, dynamic>> publisherAllData = snapshot.data!
                  .where((item) => item['continent'] == continent)
                  .toList();

              return SliverPadding(
                padding: EdgeInsets.all(16),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    Map<String, dynamic> singlePublisherData =
                        publisherAllData[index];
                    return PublisherCard(singlePublisherData);
                  }, childCount: publisherAllData.length),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                  ),
                ),
              );
            } else {
              return SliverToBoxAdapter(
                child: Center(
                  child: Text('Something happen'),
                ),
              );
            }
          },
        )
      ],
    );
  }
}

class HorizontalScrollViewDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 90,
      margin: EdgeInsets.zero,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            children: [
              for (int index = 0; index < Continent.values.length; index++)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextButtonNavigation(
                    id: index,
                    continent: Continent.values[index],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 60.0;

  @override
  double get minExtent => 60.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
