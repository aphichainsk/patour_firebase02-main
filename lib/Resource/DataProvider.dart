import 'package:cloud_firestore/cloud_firestore.dart';

class YourDataProvider {
  Stream<List<YourDataModel>> getData() {
    return FirebaseFirestore.instance.collection('tour').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return YourDataModel.fromFirestore(doc);
      }).toList();
    });
  }
}
class YourDataModel {
  final String imageUrlTour;
  final String name;
  final String category;
  final String documentId;

  YourDataModel({required this.imageUrlTour, required this.name, required this.category, required  this.documentId});

  

  factory YourDataModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return YourDataModel(
      documentId: doc.id, // เพิ่มการกำหนดค่าฟิลด์ documentId
      imageUrlTour: data['ImageLinkTour'] ?? '',
      name: data['name'] ?? '',
      category: data['category'] ?? '',
    );
  }


}

Future<void> deleteData(String id) async {
    try {
      await FirebaseFirestore.instance.collection('tour').doc(id).delete();
    } catch (error) {
      throw error;
    }
  }

