import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;


class StoredData {
  Future<String> uploadImageToString(String fileId, String fileName, Uint8List fileHotel) async {
    String fileId = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = _storage.ref().child('Hotellmages').child(fileId);
    UploadTask uploadTask = ref.putData(fileHotel);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

 Future<List<String>> uploadImages(List<Uint8List> files, String childName) async {
    List<String> downloadUrls = [];
    for (var file in files) {
        String fileId = DateTime.now().millisecondsSinceEpoch.toString();
        Reference ref = _storage.ref().child('ImageHotelGalleries').child(fileId);
        UploadTask uploadTask = ref.putData(file);
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        downloadUrls.add(downloadUrl);
    }
    return downloadUrls;
}

  Future<String> saveData({
    required String name,
    required String price,
    required String contactEmail,
    required String contactTel, 
    required String address,
    required Uint8List fileHotel,
    required List<Uint8List> galleries,
  }) async {
    String resp = "Some error occurred";
    try {
      if (name.isNotEmpty) {
        
        String imageLinkHotel = await uploadImageToString('HotelImage', 'hotel_image', fileHotel);
        List<String> galleryUrls = await uploadImages(galleries, 'GalleryImagesHotel');
        await _firestore.collection('hotel').add({
          'name': name,
          'price': price,
          'contactEmail': contactEmail,
          'contactTel': contactTel,
          'address':address,
          'ImageLinkHotel': imageLinkHotel,
          'GalleryLinks': galleryUrls,
        });
        resp = 'success';
      }
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}
