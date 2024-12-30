import 'package:cloud_firestore/cloud_firestore.dart';

abstract class HomePageService {
  static Future<List<Map<String, dynamic>>> fetchPublisherData() async {
    //Step 1: get List of publisher data QuerySnapshot
    QuerySnapshot<Map<String, dynamic>> publisherAllData =
        await FirebaseFirestore.instance
            .collection('/destinations/publisher/data') //CollectionReference
            .get();
    //Step 2: map return a new List so we can assign return value to a variable. where forEach iterate existing list
    List<Map<String, dynamic>> publisherDataList = publisherAllData.docs.map(
      (publisherDoc) {
        return publisherDoc.data();
      },
    ).toList();
    return publisherDataList;
  }
}
