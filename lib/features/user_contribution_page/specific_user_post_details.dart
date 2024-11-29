import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SpecificUserPostDetails extends StatelessWidget {
  final String imageUri;
  final String country;
  final String location;
  final String state;
  final DocumentReference userReferenceToCard;

  SpecificUserPostDetails({
    super.key,
    required this.imageUri,
    required this.country,
    required this.location,
    required this.state,
    required this.userReferenceToCard,
  });

  /* 
  * To read data from Firestore, you'll typically need a reference to the specific document or collection
  * you want to access, and then use the get() method on that reference.

  * Assuming you have a reference to a document
   const docRef = db.collection('users').doc('user1');

    docRef.get()
  .then(docSnapshot => {
    if (docSnapshot.exists) {
      const userData = docSnapshot.data();
      console.log(userData);
    } else {
      console.log('No such document!');
    }
  })
  .catch(error => {
    console.error('Error getting document:', error);
  });
   */

  Future<Map<String, dynamic>?> accessUsersData() async {
    try {
      //* Fetch the document referenced by userReferenceToCard
      DocumentSnapshot docSnapshot = await userReferenceToCard.get();

      if (docSnapshot.exists) {
        return docSnapshot.data() as Map<String, dynamic>?;
      }
    } catch (error) {
      print(
        'Error fetching user data: $error',
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: Card(
        color: Colors.white,
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: width * 0.25,
              height: height * 0.1,
              child: CachedNetworkImage(
                imageUrl: imageUri,
                fit: BoxFit.cover,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
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
                //
                placeholder: (context, url) => const CircularProgressIndicator(
                  strokeWidth: 2.0,
                  color: Colors.black,
                  //
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.green,
                  ),
                ),
                //
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 10,
                    ),
                    child: Text(
                      location,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 5, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 20,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            '$state  , $country',
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* 
FutureBuilder<Map<String, dynamic>?>(
                    future: accessUsersData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text(
                          'Error loading username',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                          ),
                        );
                      } else if (snapshot.hasData) {
                        final data = snapshot.data;
                        final name = data?['name'] ?? 'Unknown User';
                        return Text(
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          'username: $name',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                          ),
                        );
                      } else {
                        return Text(
                          'No user data available',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                          ),
                        );
                      }
                    },
                  ),

 */
