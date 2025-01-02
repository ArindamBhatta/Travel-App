import 'package:cloud_firestore/cloud_firestore.dart';

abstract class HomePageService {
  static Map<String, dynamic>? combinedData = {};

  static Future<Map<String, dynamic>?> fetchCombinedData() async {
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
      //Step 3: - current user Document
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


/* 
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class HomePageService {
  static Future<Map<String, dynamic>?> fetchPublisherData() async {
    try {
      // Initialize combined data map
      Map<String, dynamic> combinedData = {};

      // Step 1: Fetch publisher data
      CollectionReference publisherCollectionRef = FirebaseFirestore.instance.collection('/destinations/publisher/data');
      QuerySnapshot publisherSnapshot = await publisherCollectionRef.get();

      // Transform publisher data into a list of maps
      List<Map<String, dynamic>> publisherDataList = publisherSnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      // Add publisher data to combined map
      combinedData['publisherData'] = publisherDataList;

      // Extract publisher document IDs
      List<String> publisherDocumentIds = publisherSnapshot.docs.map((doc) => doc.id).toList();
      combinedData['publisherDataIds'] = publisherDocumentIds;

      // Step 2: Fetch current user data
      DocumentReference currentUserRef = FirebaseFirestore.instance.collection('users').doc('t5nmZmf1r8e6SwCqw3SJaeFoAY93');
      DocumentSnapshot currentUserSnapshot = await currentUserRef.get();

      // Validate current user data
      if (!currentUserSnapshot.exists || currentUserSnapshot.data() == null) {
        throw Exception("Current user data not found or is null");
      }

      // Add current user data to combined map
      combinedData['userData'] = currentUserSnapshot.data() as Map<String, dynamic>;

      return combinedData;
    } catch (error) {
      print("Error fetching publisher data at HomePageService.fetchPublisherData: $error");
      return null;
    }
  }
}
 */