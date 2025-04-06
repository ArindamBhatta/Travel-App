import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:travel_app/features/contributor/widgets/community_post_app_bar.dart';
import 'package:travel_app/features/contributor/widgets/sliver_pinned_text.dart';
import 'package:travel_app/features/contributor/widgets/travel_with_guide.dart';
import 'package:travel_app/features/contributor/widgets/card_view_to_details_page.dart';
import 'package:travel_app/features/home/interface/widgets/home_page_app_bar.dart';

class ContinentPage extends StatelessWidget {
  final String imageUrl;
  final String sliverHeaderTitle;
  final String continentName;
  final bool showGuideSection;
  final bool showCommunityCards;
  final bool isAsia;

  const ContinentPage({
    super.key,
    required this.imageUrl,
    required this.sliverHeaderTitle,
    required this.continentName,
    this.showGuideSection = false,
    this.showCommunityCards = false,
    this.isAsia = false,
  });

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
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
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
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                color: Colors.black,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
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
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 280,
          pinned: true,
          backgroundColor: Colors.white,
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final double currentHeight = constraints.biggest.height;
              return FlexibleSpaceBar(
                centerTitle: true,
                title: currentHeight <= 100 && isAsia
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
                  imageUrl: imageUrl,
                  titleWidget: CommunityPostAppBar(title: sliverHeaderTitle),
                ),
              );
            },
          ),
        ),
        if (isAsia) ...[
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverPinnedText(continentName),
          ),
        ],
        if (showGuideSection)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 20),
              child: Text(
                "Travel with Guide",
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        if (showGuideSection)
          SliverToBoxAdapter(
            child: SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TravelWithGuide(),
                ),
              ),
            ),
          ),
        if (showCommunityCards)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 20),
              child: Text("Community Driven location",
                  style: TextStyle(fontSize: 24)),
            ),
          ),
        if (showCommunityCards)
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => CommunityPostCard(),
              childCount: 10,
            ),
          ),
        if (!isAsia)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Explore the", style: TextStyle(fontSize: 24)),
                  Row(
                    children: [
                      const Text(
                        "Beauty of",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        continentName,
                        style: const TextStyle(
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
          ),
      ],
    );
  }
}
