import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/features/home_page/interface/widgets/from_community.dart';
import 'package:travel_app/features/home_page/interface/widgets/search_bar_container.dart';

import '../../../common/utils/google_login_provider.dart';
import '../module/data/home_page_provider.dart';
import '../../../common/utils/remote_data.dart';

import 'widgets/special_for_you.dart';
import 'widgets/card_container.dart';
import 'widgets/app_bar_Content.dart';
import 'widgets/text_button_navigation.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signInSilently();
    if (googleUser != null) {
      context.read<GoogleLoginProvider>().setUserData({
        'name': googleUser.displayName,
        'photoUrl': googleUser.photoUrl,
      });
    }
  }

  final List<String> meals = [
    'Ice Cream',
    'Rice',
    'Fish',
    'Chicken',
  ];

  final List<String> mealImages = [
    "https://images.pexels.com/photos/1294943/pexels-photo-1294943.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/11789292/pexels-photo-11789292.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/229789/pexels-photo-229789.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/1769279/pexels-photo-1769279.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredData =
        context.watch<HomePageProvider>().getFilteredTravelList();
    int lengthOfData = filteredData.length;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              elevation: 0,
              // pinned: true, //* to make the app bar pinned
              expandedHeight: 75.0,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: AppBarContent(
                  headingText: 'Where do you Wish to go',
                ),
              ),
            ),
            //* SliverPersistentHeader for sticky search bar
            SliverPersistentHeader(
              pinned: true, //* to make the search bar sticky
              delegate: SearchBarContainer(),
            ),

            SliverList(
              delegate: SliverChildListDelegate(
                [
                  //* 4 button navigation cards
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        children: [
                          TextButtonNavigation(
                            id: 0,
                            buttonText: allButtonText.All.name,
                          ),
                          const SizedBox(width: 8),
                          TextButtonNavigation(
                            id: 1,
                            buttonText: allButtonText.Popular.name,
                          ),
                          const SizedBox(width: 8),
                          TextButtonNavigation(
                            id: 2,
                            buttonText: allButtonText.Recommended.name,
                          ),
                          const SizedBox(width: 8),
                          TextButtonNavigation(
                            id: 3,
                            buttonText: allButtonText.WishListed.name,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 270,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: lengthOfData,
                      itemBuilder: (context, index) {
                        final cardData = filteredData[index];
                        int id = cardData['id'];
                        String urlImage = cardData['image'];
                        bool isAddedToWishList =
                            cardData['isUserWishListedValue'];
                        String destination = cardData['location'];
                        String destinationState = cardData['state'];
                        String destinationCountry = cardData['country'];

                        return Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: CardContainer(
                            id: id,
                            image: urlImage,
                            bookMark: isAddedToWishList,
                            location: destination,
                            state: destinationState,
                            country: destinationCountry,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  specialForYou(
                    name: 'From Community',
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return FromCommunity(
                      mealImage: mealImages[index],
                    );
                  },
                  childCount: meals.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 0.85,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
