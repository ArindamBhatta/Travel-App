import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/features/contributor/widgets/common_content_page.dart';

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
        ContinentPage(
          imageUrl:
              "https://images.pexels.com/photos/3361480/pexels-photo-3361480.jpeg",
          sliverHeaderTitle: "Weekly Spotlighted Photo",
          continentName: "Asia",
          showGuideSection: true,
          showCommunityCards: true,
          isAsia: true,
        ),
        ContinentPage(
          imageUrl: "https://images.pexels.com/photos/15286/pexels-photo.jpg",
          sliverHeaderTitle: "Most Liked This Week",
          continentName: "Africa",
          showGuideSection: true,
          showCommunityCards: true,
          isAsia: true,
        ),
        ContinentPage(
          imageUrl:
              "https://images.pexels.com/photos/31300992/pexels-photo-31300992.jpeg",
          sliverHeaderTitle: "Most Liked This Month",
          continentName: "North America",
          showGuideSection: true,
          showCommunityCards: true,
          isAsia: true,
        ),
        ContinentPage(
          imageUrl:
              "https://images.pexels.com/photos/30391778/pexels-photo-30391778.jpeg",
          sliverHeaderTitle: "Most Viewed Place",
          continentName: "South America",
          showGuideSection: true,
          showCommunityCards: true,
          isAsia: true,
        ),
        ContinentPage(
          imageUrl:
              "https://images.pexels.com/photos/18291872/pexels-photo-18291872.jpeg",
          sliverHeaderTitle: "Top Searches This Week",
          continentName: "Antarctica",
          showGuideSection: true,
          showCommunityCards: true,
          isAsia: true,
        ),
        ContinentPage(
          imageUrl:
              "https://images.pexels.com/photos/2533088/pexels-photo-2533088.jpeg",
          sliverHeaderTitle: "Top Reviewed Place",
          continentName: "Europe",
          showGuideSection: true,
          showCommunityCards: true,
          isAsia: true,
        ),
        ContinentPage(
          imageUrl:
              "https://images.pexels.com/photos/1891882/pexels-photo-1891882.jpeg",
          sliverHeaderTitle: "Suggest for this season",
          continentName: "Australia",
          showGuideSection: true,
          showCommunityCards: true,
          isAsia: true,
        ),
        ContinentPage(
          imageUrl:
              "https://images.pexels.com/photos/3475850/pexels-photo-3475850.jpeg",
          sliverHeaderTitle: "Best Travel Spot",
          continentName: "Oceania",
          showGuideSection: true,
          showCommunityCards: true,
          isAsia: true,
        ),
      ],
    );
  }
}
