import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoredData {
  Future<String> uploadImageToString(String childName, Uint8List file) async {
    String fileId = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = _storage.ref().child('ImageTour').child(fileId);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

 Future<List<String>> uploadImages(List<Uint8List> files, String childName) async {
    List<String> downloadUrls = [];
    for (var file in files) {
        String fileId = DateTime.now().millisecondsSinceEpoch.toString();
        Reference ref = _storage.ref().child('ImageTourGalleries').child(fileId);
        UploadTask uploadTask = ref.putData(file);
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        downloadUrls.add(downloadUrl);
    }
    return downloadUrls;
}


  Future<String> saveData({
    required String name,
    required String category,
    required Uint8List fileTour,
    required List<Uint8List> galleries,
    required double latitude,
    required double longitude,
    required String detailsPlace, 
  }) async {
    String resp = "Some error occurred";
    try {
      if (name.isNotEmpty || category.isNotEmpty) {
        String imageUrlTour = await uploadImageToString('PlaceImage', fileTour);
        List<String> galleryUrls = await uploadImages(galleries, 'GalleryImagesTour');
        await _firestore.collection('tour').add({
          'name': name,
          'detailsPlace':detailsPlace,
          'category': category,
          'ImageLinkTour': imageUrlTour,
          'GalleryLinks': galleryUrls,
           'latitude': latitude,
      'longitude': longitude,
        });
        resp = 'success';
      }
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }


}
