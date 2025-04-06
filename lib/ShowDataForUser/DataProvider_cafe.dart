
import 'package:cloud_firestore/cloud_firestore.dart';


class YourDataProviderCafe {
  Stream<List<YourDataModelCafe>> getData() {
    return FirebaseFirestore.instance
        .collection('tour')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return YourDataModelCafe.fromFirestore(doc);
      }).toList();
    });
  }

  Stream<List<YourDataModelCafeDetails>> getDataDetails() {
    return FirebaseFirestore.instance
        .collection('tour')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return YourDataModelCafeDetails.fromFirestore(doc);
      }).toList();
    });
  }
}

class YourDataModelCafe {
  final String imageUrlTour;
  final String name;
  final String category;

  YourDataModelCafe({
    required this.imageUrlTour,
    required this.name,
    required this.category,
  });

  factory YourDataModelCafe.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return YourDataModelCafe(
      imageUrlTour: data['ImageLinkTour'] ?? '',
      name: data['name'] ?? '',
      category: data['category'] ?? '',
    );
  }
}

class YourDataModelCafeDetails {
  final String imageUrlTour;
  final String name;
  final String category;
  final String detailsPlace;
  final List<String> galleries;
  final double latitude;
  final double longitude;

  YourDataModelCafeDetails({
    required this.imageUrlTour,
    required this.name,
    required this.category,
    required this.detailsPlace,
    required this.galleries,
    required this.latitude,
    required this.longitude,
  });

  factory YourDataModelCafeDetails.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return YourDataModelCafeDetails(
        imageUrlTour: data['ImageLinkTour'] ?? '',
        name: data['name'] ?? '',
        category: data['category'] ?? '',
        detailsPlace: data['detailsPlace'] ?? '',
        galleries: List<String>.from(data['GalleryLinks'] ?? []),
        //latitude: (data['latitude'] ?? 0).toDouble(), // แปลงค่าเป็น double
        //longitude: (data['longitude'] ?? 0).toDouble(), // แปลงค่าเป็น double
        latitude: (data['latitude'] ?? 0).toDouble(),
        longitude: (data['longitude'] ?? 0).toDouble());
  }
}
