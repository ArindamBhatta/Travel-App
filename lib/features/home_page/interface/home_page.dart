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
                  //* Card Container

                  SizedBox(
                    height: 270,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16),
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

                        return CardContainer(
                          id: id,
                          image: urlImage,
                          bookMark: isAddedToWishList,
                          location: destination,
                          state: destinationState,
                          country: destinationCountry,
                        );
                      },
                    ),
                  ),

                  /////////////////
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
                      allContributorsImage:
                          'https://images.pexels.com/photos/4482677/pexels-photo-4482677.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                    );
                  },
                  childCount: 4,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
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
