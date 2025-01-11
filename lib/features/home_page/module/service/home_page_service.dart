import 'package:cloud_firestore/cloud_firestore.dart';

abstract class HomePageService {
  static Map<String, dynamic>? combinedData = {};

  static Future<Map<String, dynamic>?> fetchAllFireStoreData() async {
    try {
      // Firestore collection Reference
      CollectionReference pathOfPublisherData =
          FirebaseFirestore.instance.collection('/destinations/publisher/data');

      // QuerySnapshot by using get()
      QuerySnapshot publisherAllData = await pathOfPublisherData.get();

      // QuerySnapshot List by using docs
      List<QueryDocumentSnapshot<Object?>> listOfAllPublisherDocumentSnapshot =
          publisherAllData.docs;

      // DocumentReference by using map
      List<Map<String, dynamic>> listOfPublisherData =
          listOfAllPublisherDocumentSnapshot
              .map((DocumentSnapshot destination) {
        Map<String, dynamic> dataItem =
            destination.data() as Map<String, dynamic>;
        dataItem['id'] = destination.id;
        return dataItem;
      }).toList();

      combinedData!['publisherData'] = listOfPublisherData;

      // current user Document
      DocumentReference currentUserPath = FirebaseFirestore.instance
          .collection('users')
          .doc('t5nmZmf1r8e6SwCqw3SJaeFoAY93');

      DocumentSnapshot currentUserSnapshot = await currentUserPath.get();

      // Validate current user data
      if (!currentUserSnapshot.exists || currentUserSnapshot.data() == null) {
        throw Exception("Current user data not found or is null");
      }

      // get current user
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
