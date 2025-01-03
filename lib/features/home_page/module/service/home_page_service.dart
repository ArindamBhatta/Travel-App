import 'package:cloud_firestore/cloud_firestore.dart';

abstract class HomePageService {
  static Map<String, dynamic>? combinedData = {};

  static Future<Map<String, dynamic>?> fetchAllFireStoreData() async {
    try {
      //Step: 1 Get the Publisher Data

      // Reference to the Firestore collection
      CollectionReference pathOfPublisherData =
          FirebaseFirestore.instance.collection('/destinations/publisher/data');
      // by using get() method we get QuerySnapshot
      QuerySnapshot publisherAllData = await pathOfPublisherData.get();

      // get the whole snapshot list
      List<QueryDocumentSnapshot<Object?>> listOfAllPublisherDocumentSnapshot =
          publisherAllData.docs;

      List<Map<String, dynamic>> listOfPublisherData =
          listOfAllPublisherDocumentSnapshot
              .map((DocumentSnapshot destination) {
        return destination.data() as Map<String, dynamic>;
      }).toList();
      combinedData!['publisherData'] = listOfPublisherData;

      //Step 2: - Get the Publisher document reference
      List<String> listOfPublisherDataIds = listOfAllPublisherDocumentSnapshot
          .map((DocumentSnapshot destination) {
        return destination.id;
      }).toList();
      combinedData!['publisherDataIds'] = listOfPublisherDataIds;

      //Step 3 method 2 : - current user Document
      DocumentReference currentUserPath = FirebaseFirestore.instance
          .collection('users')
          .doc('t5nmZmf1r8e6SwCqw3SJaeFoAY93');

      DocumentSnapshot currentUserSnapshot = await currentUserPath.get();

      // Validate current user data
      if (!currentUserSnapshot.exists || currentUserSnapshot.data() == null) {
        throw Exception("Current user data not found or is null");
      }

      Map<String, dynamic> currentUserData =
          currentUserSnapshot.data() as Map<String, dynamic>;

      combinedData!['userData'] = currentUserData;

      return combinedData;
    } catch (error) {
      print("Error fetching publisher data: $error");
      return null;
    }
  }
}
