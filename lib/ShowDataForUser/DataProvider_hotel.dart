import 'package:cloud_firestore/cloud_firestore.dart';

class YourDataProviderHotel {
  Stream<List<YourDataModelHotel>> getData() {
    return FirebaseFirestore.instance
        .collection('hotel')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return YourDataModelHotel.fromFirestore(doc);
      }).toList();
    });
  }

  Stream<List<YourDataModelHotelDetails>> getDataDetails() {
    return FirebaseFirestore.instance
        .collection('hotel')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return YourDataModelHotelDetails.fromFirestore(doc);
      }).toList();
    });
  }
}

class YourDataModelHotel {
  final String imageUrlTour;
  final String name;

  YourDataModelHotel({
    required this.imageUrlTour,
    required this.name,
  });

  factory YourDataModelHotel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return YourDataModelHotel(
      imageUrlTour: data['ImageLinkHotel'] ?? '',
      name: data['name'] ?? '',
    );
  }
}

class YourDataModelHotelDetails {
  final String imageUrlHotel;
  final String name;
  final String detailsPlace;
  final List<String> galleries;
  final String contactEmail;
  final String contactTel;
  final String price;
  final String address;

  YourDataModelHotelDetails(
      {required this.imageUrlHotel,
      required this.name,
      required this.detailsPlace,
      required this.galleries,
      required this.price,
      required this.contactEmail,
      required this.contactTel,
      required this.address});

  factory YourDataModelHotelDetails.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return YourDataModelHotelDetails(
        imageUrlHotel: data['ImageLinkHotel'] ?? '',
        name: data['name'] ?? '',
        detailsPlace: data['detailsPlace'] ?? '',
        galleries: List<String>.from(data['GalleryLinks'] ?? []),
        price: data['price'] ?? '',
        contactEmail: data['contactEmail'] ?? '',
        contactTel: data['contactTel'] ?? '',address: data['address'] ?? ''
        
        );
  }
}
