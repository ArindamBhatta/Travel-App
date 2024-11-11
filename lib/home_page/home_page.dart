import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/provider/home_page_provider.dart';
import 'package:travel_app/provider/model.dart';
import '../home_Page/special_for_you_text.dart';
import './book_mark_card.dart';
import '../home_Page/prime_location_card.dart';
import 'text_button_control_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<Map<String, dynamic>> filteredData =
        context.watch<HomePageProvider>().getFilteredTravelList();
    int lengthOfData = filteredData.length;

    Widget appBarContent() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/profile_picture.jpg',
              ),
            ),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jihan Audy,',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Where do you want to go?',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Spacer(),
            Icon(
              Icons.notification_add_outlined,
              color: Colors.black,
            ),
          ],
        ),
      );
    }

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
              expandedHeight: 120.0,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: appBarContent(),
              ),
            ),

            ///////////////
            SliverPersistentHeader(
              pinned: true,
              delegate: _SearchBarDelegate(),
            ),
            //////////////////

            SliverList(
              delegate: SliverChildListDelegate([
                //* 4 button navigation cards
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Row(
                      children: [
                        TextButtonControlCard(
                          id: 0,
                          buttonText: allButtonText.All.name,
                        ),
                        SizedBox(width: 8),
                        TextButtonControlCard(
                          id: 1,
                          buttonText: allButtonText.Popular.name,
                        ),
                        SizedBox(width: 8),
                        TextButtonControlCard(
                          id: 2,
                          buttonText: allButtonText.Recommended.name,
                        ),
                        SizedBox(width: 8),
                        TextButtonControlCard(
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
                        child: BookMarkCard(
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
                SpecialForYouText(),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: PrimeLocationCard(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: PrimeLocationCard(),
                      ),
                    ],
                  ),
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
                onPressed: () {},
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

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(12),
          ),
          fillColor: Colors.white,
          hintText: 'Search',
          prefixIcon: Icon(Icons.search),
          suffixIcon: Icon(Icons.tune_outlined),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(12),
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
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
