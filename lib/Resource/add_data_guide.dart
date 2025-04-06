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
    Reference ref = _storage.ref().child('ImageGuide').child(fileId);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  

  Future<String> saveData({
    required String name,
    required String contactEmail,
    required String contactTel, 
    required Uint8List imageGuide,


  }) async {
    String resp = "Some error occurred";
    try {
      if (name.isNotEmpty ) {
        String imageLinkGuide = await uploadImageToString('imageGuide', imageGuide);
       
        await _firestore.collection('guide').add({
          'name': name,
          'contactEmail': contactEmail,
          'contactTel':contactTel,
          'ImageLinkGuide': imageLinkGuide,
     
        });
        resp = 'success';
      }
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }


}
