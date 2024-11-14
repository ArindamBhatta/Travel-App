import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../../common/utils/google_login_provider.dart';
import '../module/data/home_page_provider.dart';
import '../../../common/utils/remote_data.dart';
import 'widgets/chat_page.dart';
import 'widgets/search_bar.dart';
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
    checkLoginStatus();
    super.initState();
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
    double width = MediaQuery.of(context).size.width;
    List<Map<String, dynamic>> filteredData =
        context.watch<HomePageProvider>().getFilteredTravelList();
    int lengthOfData = filteredData.length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              elevation: 0,
              //* pinned: true,  to make the app bar pinned
              expandedHeight: 65.0,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: AppBarContent(),
              ),
            ),

            //* SliverPersistentHeader for sticky search bar
            SliverPersistentHeader(
              pinned: true, //* to make the search bar sticky
              delegate: SearchBarDelegate(),
            ),

            SliverList(
              delegate: SliverChildListDelegate([
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
                        SizedBox(width: 8),
                        TextButtonNavigation(
                          id: 1,
                          buttonText: allButtonText.Popular.name,
                        ),
                        SizedBox(width: 8),
                        TextButtonNavigation(
                          id: 2,
                          buttonText: allButtonText.Recommended.name,
                        ),
                        SizedBox(width: 8),
                        TextButtonNavigation(
                          id: 3,
                          buttonText: allButtonText.WishListed.name,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 300.0,
                  //* Creating the cards
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
                  name: 'Special for you',
                ),

                SizedBox(height: 800), // to allow scrolling
              ]),
            ),
          ],
        ),
      ),

      ///////////////////
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FloatingActionButton.extended(
          heroTag: 'unique_fab_id_2',
          elevation: 1,
          backgroundColor: Colors.white,
          onPressed: () {},
          label: Row(
            children: [
              TextButton(
                child: Icon(
                  Icons.home,
                  color: Colors.blue,
                ),
                onPressed: () {},
              ),
              SizedBox(width: width * 0.08),
              TextButton(
                child: Icon(
                  Icons.messenger_outline,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(),
                    ),
                  );
                },
              ),
              SizedBox(width: width * 0.08),
              TextButton(
                child: Icon(
                  Icons.notification_add_outlined,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
              SizedBox(width: width * 0.08),
              TextButton(
                child: Icon(
                  Icons.settings_outlined,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
