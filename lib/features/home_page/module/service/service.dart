import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Service {
  static Future<List<Map<String, dynamic>>> fetchPublisherData() async {
    QuerySnapshot<Map<String, dynamic>> jsonQuerySnapshot =
        await FirebaseFirestore.instance
            .collection('/destinations/publisher/data')
            .get();

    List<Map<String, dynamic>> publisherDataList = jsonQuerySnapshot.docs.map(
      (publisherDoc) {
        return publisherDoc.data();
      },
    ).toList();
    return publisherDataList;
  }
}
