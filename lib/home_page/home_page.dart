import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../home_Page/special_for_you_text.dart';
import './book_mark_card.dart';
import '../home_Page/prime_location_card.dart';
import 'provider/home_page_provider.dart';
import 'text_button_control_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    //* Retrieve the filtered list based on the selected filter
    List<Map<String, dynamic>> filteredData =
        context.watch<HomePageProvider>().getFilteredTravelList();

    int lengthOfData = filteredData.length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            //* User info
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/images/profile_picture.jpg',
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
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
            ),
            //* Search bar
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
            ),
            SizedBox(height: 20),
            //*  4 button to navigation cards
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    TextButtonControlCard(
                        id: 0, buttonText: allButtonText.All.name),
                    SizedBox(width: 8),
                    TextButtonControlCard(
                        id: 1, buttonText: allButtonText.Popular.name),
                    SizedBox(width: 8),
                    TextButtonControlCard(
                        id: 2, buttonText: allButtonText.Recommended.name),
                    SizedBox(width: 8),
                    TextButtonControlCard(
                        id: 3, buttonText: allButtonText.WishListed.name),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(
                      height: 300.0,
                      //* Creating the cards
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: lengthOfData,
                        itemBuilder: (context, index) {
                          //* in CardData we assign filterData with specific index
                          final cardData =
                              filteredData[index]; //* index ->| 0 | 1 | 2 | 3 |
                          String urlImage = cardData['image'];
                          bool isAddedToWishList =
                              cardData['isUserWishListedValue'];
                          String destination = cardData['location'];
                          String destinationState = cardData['state'];
                          String destinationCountry = cardData['country'];

                          void toggleWishList(int index) {
                            context.read<HomePageProvider>().toggleWishList(
                                index); //* toggle wish list also done from details page pass to child card container
                          }

                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0), //for single card shifting
                            child: BookMarkCard(
                              key: ValueKey(index),
                              id: index,
                              image: urlImage,
                              bookMark: isAddedToWishList,
                              location: destination,
                              state: destinationState,
                              country: destinationCountry,
                              toggleWishListMethod: () {
                                //* passing whole method to a key so we pass separate index value with instantiate
                                toggleWishList(index);
                              },
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
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
