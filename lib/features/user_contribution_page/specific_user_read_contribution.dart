import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SpecificUserReadContribution extends StatelessWidget {
  final DocumentReference userSpecificPost;

  SpecificUserReadContribution({
    super.key,
    required this.userSpecificPost,
  });

  Future<Map<String, dynamic>?> accessUsersPost() async {
    try {
      DocumentSnapshot docSnapshot = await userSpecificPost.get();

      if (docSnapshot.exists) {
        final fireStoreData = docSnapshot.data() as Map<String, dynamic>?;
        return fireStoreData;
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

    return FutureBuilder<Map<String, dynamic>?>(
      future: accessUsersPost(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error loading username',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        } else if (snapshot.hasData) {
          final data = snapshot.data;
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
                      imageUrl: '${data?['image']}',
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
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(
                        strokeWidth: 2.0,
                        color: Colors.black,
                        //
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.green,
                        ),
                      ),
                      //
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
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
                            '${data?['location']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 5, top: 5, bottom: 10),
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
                                  '${data?['state']}'
                                  '${data?['country']}',
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
        } else {
          return Text(
            'Some error are occur',
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          );
        }
      },
    );
  }
}
