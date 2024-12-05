import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailsPageExtension extends StatelessWidget {
  final DocumentReference uploadedUser;

  DetailsPageExtension(this.uploadedUser);

  Future<Map<String, dynamic>?> fetchContributor() async {
    try {
      DocumentReference user = uploadedUser;

      DocumentSnapshot docSnapshot = await user.get();
      if (docSnapshot.exists) {
        return docSnapshot.data() as Map<String, dynamic>?;
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
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

    return FutureBuilder<Map<String, dynamic>?>(
      future: fetchContributor(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading data'));
        } else if (snapshot.hasData) {
          Map<String, dynamic> data = snapshot.data!;

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data['name'],
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
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Colors.teal[500],
                        ),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            side: BorderSide(color: Colors.teal, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Overview",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Details",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Reviews",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Darjeeling is one of the world’s new holiday destinations in West Bengal. Located on the west Bengal of the India.',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                SizedBox(height: 20),
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
