import 'package:cloud_firestore/cloud_firestore.dart';

class YourDataProviderGuide {
  Stream<List<YourDataModelGuide>> getData() {
    return FirebaseFirestore.instance.collection('guide').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return YourDataModelGuide.fromFirestore(doc);
      }).toList();
    });
  }
}
class YourDataModelGuide {
  final String imageUrlGuide;
  final String name;
  final String documentId;

  YourDataModelGuide({required this.imageUrlGuide, required this.name,  required  this.documentId});

  

  factory YourDataModelGuide.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return YourDataModelGuide(
      documentId: doc.id, // เพิ่มการกำหนดค่าฟิลด์ documentId
      imageUrlGuide: data['ImageLinkGuide'] ?? '',
      name: data['name'] ?? '',
     
    );
  }


}

Future<void> deleteData(String id) async {
    try {
      await FirebaseFirestore.instance.collection('guide').doc(id).delete();
    } catch (error) {
      throw error;
    }
  }

