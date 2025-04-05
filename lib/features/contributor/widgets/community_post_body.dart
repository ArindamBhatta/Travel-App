import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/features/contributor/widgets/card_view_to_details_page.dart';

import 'package:travel_app/features/contributor/widgets/community_post_app_bar.dart';
import 'package:travel_app/features/contributor/widgets/sliver_pinned_text.dart';
import 'package:travel_app/features/contributor/widgets/travel_with_guide.dart';
import 'package:travel_app/features/home/interface/widgets/home_page_app_bar.dart';

class CommunityPostBody extends StatefulWidget {
  @override
  _CommunityPostBodyState createState() => _CommunityPostBodyState();
}

class _CommunityPostBodyState extends State<CommunityPostBody> {
  Widget buildFeaturePage({
    required String imageUrl,
    required Widget titleWidget,
  }) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationX(3.1416),
          child: CachedNetworkImage(
            imageUrl: '$imageUrl',
            fit: BoxFit.cover,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    8.0,
                  ),
                  topRight: Radius.circular(
                    8.0,
                  ),
                ),
                color: Colors.transparent,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  colorFilter: const ColorFilter.mode(
                    Color.fromARGB(255, 254, 189, 184),
                    BlendMode.colorBurn,
                  ),
                ),
              ),
            ),
            placeholder: (context, url) => Center(
              child: const CircularProgressIndicator(
                strokeWidth: 2.0,
                color: Colors.black,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.green,
                ),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(
              Icons.error,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: titleWidget,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      children: [
        // Page 1 — Most viewed Asia
        CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 280,
              pinned: true,
              backgroundColor: Colors.white,
              flexibleSpace: LayoutBuilder(
                builder: (
                  BuildContext context,
                  BoxConstraints constraints,
                ) {
                  final double currentHeight = constraints.biggest.height;

                  return FlexibleSpaceBar(
                    centerTitle: true,
                    title: currentHeight <= 100
                        ? SafeArea(
                            child: HomePageAppBar(
                              calling: false,
                              userInfo: {},
                              headingText: 'Wanderly',
                              onNotificationTap: () {},
                            ),
                          )
                        : null,
                    background: buildFeaturePage(
                      imageUrl:
                          "https://images.pexels.com/photos/3361480/pexels-photo-3361480.jpeg",
                      titleWidget: const CommunityPostAppBar(
                        title: "Weekly Spotlighted Photo",
                      ),
                    ),
                  );
                },
              ),
            ),
            //! ❌ Wrong: a sliver widget cant inside a box widget or Column.
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverPinnedText(),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 20),
                child: Text(
                  "Travel with Guide",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ),

            //Create Dummy cards
            SliverToBoxAdapter(
              child: Container(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TravelWithGuide(),
                    );
                  },
                ),
              ),
            ),

            //User contributed picture
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 20),
                child: Text(
                  "Community Driven location",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ),

            //
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return CommunityPostCard();
                },
                childCount: 10,
              ),
            ),
          ],
        ),

        // Page 2 — Most liked Africa
        CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 280,
              pinned: true,
              backgroundColor: Colors.black87,
              flexibleSpace: FlexibleSpaceBar(
                background: buildFeaturePage(
                  imageUrl:
                      "https://images.pexels.com/photos/15286/pexels-photo.jpg",
                  titleWidget: const CommunityPostAppBar(
                    title: "Most Liked This Week",
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Explore the",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        Row(
                          spacing: 8,
                          children: [
                            Text(
                              "Beauty of",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              "Africa",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.amber,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        // Page 3 — Most liked North America
        CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 280,
              pinned: true,
              backgroundColor: Colors.black87,
              flexibleSpace: FlexibleSpaceBar(
                background: buildFeaturePage(
                  imageUrl:
                      "https://images.pexels.com/photos/31300992/pexels-photo-31300992/free-photo-of-stunning-view-of-the-glenfinnan-viaduct-in-scotland.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
                  titleWidget: const CommunityPostAppBar(
                    title: "Most Liked This Month",
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Explore the",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        Row(
                          spacing: 8,
                          children: [
                            Text(
                              "Beauty of",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              "North America",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.amber,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        //page 4 South America
        CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 280,
              pinned: true,
              backgroundColor: Colors.black87,
              flexibleSpace: FlexibleSpaceBar(
                background: buildFeaturePage(
                  imageUrl:
                      "https://images.pexels.com/photos/30391778/pexels-photo-30391778/free-photo-of-charming-autumn-scene-in-amsterdam-park.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                  titleWidget: const CommunityPostAppBar(
                    title: "Most Viewed Place",
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Explore the",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        Row(
                          spacing: 8,
                          children: [
                            Text(
                              "Beauty of",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              "South America",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.amber,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        //page 5 Antarctica
        CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 280,
              pinned: true,
              backgroundColor: Colors.black87,
              flexibleSpace: FlexibleSpaceBar(
                background: buildFeaturePage(
                  imageUrl:
                      "https://images.pexels.com/photos/18291872/pexels-photo-18291872/free-photo-of-lotus-with-pink-petals-and-dark-green-leaves.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                  titleWidget: const CommunityPostAppBar(
                    title: "Top Searches This Week",
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Explore the",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        Row(
                          spacing: 8,
                          children: [
                            Text(
                              "Beauty of",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              "Antarctica",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.amber,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        //Page 6 Europe
        CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 280,
              pinned: true,
              backgroundColor: Colors.black87,
              flexibleSpace: FlexibleSpaceBar(
                background: buildFeaturePage(
                  imageUrl:
                      "https://images.pexels.com/photos/2533088/pexels-photo-2533088.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                  titleWidget: const CommunityPostAppBar(
                    title: "Top Reviewed Place",
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Explore the",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        Row(
                          spacing: 8,
                          children: [
                            Text(
                              "Beauty of",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              "Europe",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.amber,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        //Page 7 Australia
        CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 280,
              pinned: true,
              backgroundColor: Colors.black87,
              flexibleSpace: FlexibleSpaceBar(
                background: buildFeaturePage(
                  imageUrl:
                      "https://images.pexels.com/photos/1891882/pexels-photo-1891882.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                  titleWidget: const CommunityPostAppBar(
                    title: "Suggest for this season",
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Explore the",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        Row(
                          spacing: 8,
                          children: [
                            Text(
                              "Beauty of",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              "Australia",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.amber,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        //Page 8 Oceania
        CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 280,
              pinned: true,
              backgroundColor: Colors.black87,
              flexibleSpace: FlexibleSpaceBar(
                background: buildFeaturePage(
                  imageUrl:
                      "https://images.pexels.com/photos/3475850/pexels-photo-3475850.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                  titleWidget: const CommunityPostAppBar(
                    title: "best travel spot",
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Explore the",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        Row(
                          spacing: 8,
                          children: [
                            Text(
                              "Beauty of",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              "Oceania",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.amber,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
