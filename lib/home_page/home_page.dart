import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../home_Page/special_for_you_text.dart';
import './book_mark_card.dart';
import '../home_Page/prime_location_card.dart';
import '../home_Page/booking_button.dart';
import 'provider/wish_list_provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  bool isSelected = false;
  List<String> list = <String>['Explorer', 'Two', 'Three', 'Four'];

  void selectedButton() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    List<Map<String, dynamic>> allFilterData =
        Provider.of<WishListProvider>(context).wishListCardContent(
            Provider.of<WishListProvider>(context).travelList);

    int lengthOfData = allFilterData.length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/profile_picture.jpg'),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    BookingButton(
                      buttonText: "All",
                      isSelected: isSelected,
                      onPressed: selectedButton,
                    ),
                    SizedBox(width: 10),
                    BookingButton(
                      buttonText: "Popular",
                      isSelected: true,
                      onPressed: selectedButton,
                    ),
                    SizedBox(width: 10),
                    BookingButton(
                      buttonText: "Recommended",
                      isSelected: isSelected,
                      onPressed: selectedButton,
                    ),
                    SizedBox(width: 10),
                    BookingButton(
                      buttonText: "Most Popular",
                      isSelected: isSelected,
                      onPressed: selectedButton,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SizedBox(
                        height: 280,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: lengthOfData,
                          itemBuilder: (context, index) {
                            String urlImage = allFilterData[index]['image'];

                            bool isAddedToWishList =
                                allFilterData[index]['isVisible'];

                            String destination =
                                allFilterData[index]['location'];

                            String destinationState =
                                allFilterData[index]['state'];

                            String destinationCountry =
                                allFilterData[index]['country'];

                            void toggleWishList(int index) {
                              context
                                  .read<WishListProvider>()
                                  .toggleWishList(index);
                            }

                            return Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: BookMarkCard(
                                id: index,
                                image: urlImage,
                                bookMark: isAddedToWishList,
                                location: destination,
                                state: destinationState,
                                country: destinationCountry,
                                toggleWishListMethod: () {
                                  toggleWishList(index);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SpecialForYouText(
                      itemButtonList: list,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          PrimeLocationCard(
                            itemButtonList: list,
                          ),
                          PrimeLocationCard(
                            itemButtonList: list,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 110),
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
