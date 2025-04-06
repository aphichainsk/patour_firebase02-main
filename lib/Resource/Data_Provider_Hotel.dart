import 'package:cloud_firestore/cloud_firestore.dart';

class YourDataProviderHotel {
  Stream<List<YourDataModelHotel>> getData() {
    return FirebaseFirestore.instance.collection('hotel').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return YourDataModelHotel.fromFirestore(doc);
      }).toList();
    });
  }
}
class YourDataModelHotel {
  final String imageLinkHotel;
  final String name;
  final String documentId;

  YourDataModelHotel({required this.imageLinkHotel, required this.name,  required  this.documentId});

  

  factory YourDataModelHotel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return YourDataModelHotel(
      documentId: doc.id, // เพิ่มการกำหนดค่าฟิลด์ documentId
      imageLinkHotel: data['ImageLinkHotel'] ?? '',
      name: data['name'] ?? '',
     
    );
  }


}

Future<void> deleteData(String id) async {
    try {
      await FirebaseFirestore.instance.collection('hotel').doc(id).delete();
    } catch (error) {
      throw error;
    }
  }

