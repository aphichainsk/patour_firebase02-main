import 'package:cloud_firestore/cloud_firestore.dart';

class YourDataProviderGuide {
  Stream<List<YourDataModelGuide>> getData() {
    return FirebaseFirestore.instance
        .collection('guide')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return YourDataModelGuide.fromFirestore(doc);
      }).toList();
    });
  }

  Stream<List<YourDataModelGuideDetails>> getDataDetails() {
    return FirebaseFirestore.instance
        .collection('guide')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return YourDataModelGuideDetails.fromFirestore(doc);
      }).toList();
    });
  }
}

class YourDataModelGuide {
  final String imageUrlGuide;
  final String name;

  YourDataModelGuide({
    required this.imageUrlGuide,
    required this.name,
  });

  factory YourDataModelGuide.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return YourDataModelGuide(
      imageUrlGuide: data['ImageLinkGuide'] ?? '',
      name: data['name'] ?? '',
    );
  }
}

class YourDataModelGuideDetails {
  final String imageUrlGuide;
  final String name;
  final String contactEmail;
  final String contactTel;


  YourDataModelGuideDetails(
      {required this.imageUrlGuide,
      required this.name,
      required this.contactEmail,
      required this.contactTel
     
    });

  factory YourDataModelGuideDetails.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return YourDataModelGuideDetails(
        imageUrlGuide: data['ImageLinkGuide'] ?? '',
        name: data['name'] ?? '',
        contactEmail: data['contactEmail'] ?? '',
        contactTel: data['contactTel'] ?? ''
        
        );
  }
}
