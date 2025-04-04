import 'package:flutter/material.dart';

import 'package:travel_app/features/contributor/widgets/community_post_app_bar.dart';
import 'package:travel_app/features/contributor/widgets/sliver_pinned_text.dart';

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
        Image.network(
          imageUrl,
          fit: BoxFit.cover,
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
              backgroundColor: Colors.black87,
              flexibleSpace: LayoutBuilder(
                builder: (
                  BuildContext context,
                  BoxConstraints constraints,
                ) {
                  final double currentHeight = constraints.biggest.height;

                  return FlexibleSpaceBar(
                    centerTitle: true,
                    title: currentHeight <= 100
                        ? const Text(
                            "Wanders of Asia",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
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
              child: Container(
                height: 1000,
              ),
            )
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
