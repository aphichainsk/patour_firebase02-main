import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patour_firebase02/Admin/Admin_page/utils.dart';
import 'package:patour_firebase02/Resource/add_data_hotel.dart';
import 'package:patour_firebase02/utils/style.dart';

class AddHotel extends StatefulWidget {
  const AddHotel({super.key});

  @override
  State<AddHotel> createState() => _AddhotelState();
}

class _AddhotelState extends State<AddHotel> {
  List<Uint8List> gallery = [];
  Uint8List? _imageHotel;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController contactEmailController = TextEditingController();
  final TextEditingController contactTelController = TextEditingController();
  final TextEditingController addressTelController = TextEditingController();
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _imageHotel = img;
    });
  }

  void selectMultiImages() async {
    List<XFile>? pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles != null) {
      List<Uint8List> images = [];
      for (var file in pickedFiles) {
        images.add(await file.readAsBytes());
      }
      setState(() {
        gallery = images;
      });
    }
  }

  void saveHotel() async {
    String name = nameController.text;
    Uint8List fileHotel = _imageHotel!;
    String price = priceController.text;
    String contactEmail = contactEmailController.text;
    String contactTel = contactTelController.text;
    String address = addressTelController.text;
    List<Uint8List> galleries = gallery;


    if (name != null && name.isNotEmpty) {
      // แสดงสถานะการดำเนินการ
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Saving Hotel...'),
                SizedBox(height: 16.0),
                CircularProgressIndicator(),
              ],
            ),
          );
        },
      );

      String resp = await StoredData().saveData(
          name: name,
          price: price,
          contactEmail: contactEmail,
          contactTel: contactTel,
          address: address,
          fileHotel: fileHotel,
          galleries: galleries,
          );
      Navigator.of(context).pop(); // ปิด AlertDialog ที่แสดงสถานะการดำเนินการ

      print(resp);
      if (resp == 'success') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Save Hotel Successfully!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Alert'),
            content: Text('Please select a category.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Add Hotel')),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    _imageHotel != null
                        ? Container(
                            height: 200,
                            width: 300,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: MemoryImage(_imageHotel!),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.blueAccent),
                            ),
                          )
                        : Container(
                            height: 200,
                            width: 300,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.blueAccent),
                            ),
                            child: IconButton(
                              onPressed: selectImage,
                              icon: Icon(Icons.add_a_photo),
                            ),
                          ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Hotel Name',
                  style: heading3,
                ),
              ),
              //Add Name
              Container(
                padding: EdgeInsets.only(left: 10, top: 5),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Name',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Price',
                  style: heading3,
                ),
              ),
              //Add Price
              Container(
                padding: EdgeInsets.only(left: 10, top: 5),
                child: TextField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    hintText: 'Price/Day',
                  ),
                ),
              ),

              //Add Contact : email
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  'E-mail',
                  style: heading3,
                ),
              ),
              Container(
                 padding: EdgeInsets.only(left: 10, top: 5),
                child: TextField(
                  controller: contactEmailController,
                  decoration: const InputDecoration(
                    hintText: 'E-mail',
                  ),
                ),
              ),
              //Add Contact : tel
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Tel Number',
                  style: heading3,
                ),
              ),
              Container(
                     padding: EdgeInsets.only(left: 10, top: 5),
                child: TextField(
                  controller: contactTelController,
                  decoration: const InputDecoration(
                    hintText: 'Tel.000-000-0000',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Address',
                  style: heading3,
                ),
              ),
              Container(
                     padding: EdgeInsets.only(left: 10, top: 5),
                child: TextField(
                  controller: addressTelController,
                  decoration: const InputDecoration(
                    hintText: 'details address',
                  ),
                ),
              ),
              Container(padding: EdgeInsets.all(10),
                child: Text(
                  'Add Gallery',
                  style: heading3,
                ),),
              Container(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Column(
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: gallery.length + 1,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          if (index == gallery.length) {
                            return GestureDetector(
                              onTap: selectMultiImages,
                              child: Container(
                                color: Colors.grey,
                                child: Icon(Icons.add),
                              ),
                            );
                          } else {
                            return Image.memory(
                              gallery[index],
                              fit: BoxFit.cover,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
             SizedBox(height: 10,),
              Center(
                child: ElevatedButton(
                  onPressed: saveHotel,
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        )));
  }
}
