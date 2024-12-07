import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailsPageExtension extends StatefulWidget {
  final DocumentReference uploadedUser;
  final String location;
  DetailsPageExtension(
    this.uploadedUser,
    this.location,
  );

  @override
  State<DetailsPageExtension> createState() => _DetailsPageExtensionState();
}

class _DetailsPageExtensionState extends State<DetailsPageExtension> {
  Future<Map<String, dynamic>?> fetchContributor() async {
    try {
      DocumentReference user = widget.uploadedUser;

      DocumentSnapshot docSnapshot = await user.get();
      if (docSnapshot.exists) {
        return docSnapshot.data() as Map<String, dynamic>?;
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
    return null;
  }

  Widget infoAboutTrip(
    IconData icon,
    Color color,
    String textOfInfo,
    String infoText,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            SizedBox(width: 4),
            Text(
              textOfInfo,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        Text(infoText),
      ],
    );
  }

  int selectedButtonId = 0;
  PageController ctrl = PageController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: fetchContributor(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Container(
            color: Colors.white,
            height: 300,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ));
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error loading data',
            ),
          );
        } else if (snapshot.hasData) {
          Map<String, dynamic> data = snapshot.data!;

          return Container(
            height: 300,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.location,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '4500',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 20),
                        SizedBox(width: 4),
                        Text(
                          '4.5 (2.7k)',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Text(
                      "* Estimated Cost",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      TabBar(
                        indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 1.5,
                          ),
                        ),
                        tabs: [
                          Text(
                            'Description',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Details',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'User info',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 140,
                        child: TabBarView(
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                      'Darjeeling is one of the world’s new holiday destinations in West Bengal. Located on the west Bengal of the India.',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      infoAboutTrip(
                                        Icons.watch_later,
                                        Colors.red,
                                        '2 Days',
                                        "Duration",
                                      ),
                                      infoAboutTrip(
                                        Icons.location_on,
                                        Colors.green,
                                        '100 KM',
                                        "Distance",
                                      ),
                                      infoAboutTrip(
                                        Icons.wb_sunny_rounded,
                                        Colors.yellow,
                                        "13 °C",
                                        "Weather",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 100,
                              color: Colors.green,
                            ),
                            Container(
                              height: 100,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[500],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Book Now",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Text(
              'No data available',
            ),
          );
        }
      },
    );
  }
}
