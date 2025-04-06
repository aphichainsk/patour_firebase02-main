import 'dart:ffi';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patour_firebase02/Resource/add_data.dart';
import 'package:patour_firebase02/Admin/Admin_page/ManageTour.dart';
import 'package:patour_firebase02/Admin/Admin_page/utils.dart';
import 'package:patour_firebase02/utils/style.dart';

class AddtouristAtt extends StatefulWidget {
  const AddtouristAtt({Key? key}) : super(key: key);

  @override
  _AddtouristAttState createState() => _AddtouristAttState();
}

class _AddtouristAttState extends State<AddtouristAtt> {
  Uint8List? _imageTour;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController detailscontroller = TextEditingController();
  String? _selectedCategory;
  List<Uint8List> gallery = [];
  late GoogleMapController _controller;
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _imageTour = img;
    });
  }

  void savePlace() async {
    String name = nameController.text;
    Uint8List fileTour = _imageTour!;
    String? category = _selectedCategory;
    String detailsPlace = detailscontroller.text;
    double latitude = double.parse(latitudeController.text);
    double longitude = double.parse(longitudeController.text);
    List<Uint8List> galleries = gallery;

    if (category != null && category.isNotEmpty) {
      // แสดงสถานะการดำเนินการ
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Saving place...'),
                SizedBox(height: 16.0),
                CircularProgressIndicator(),
              ],
            ),
          );
        },
      );

      String resp = await StoredData().saveData(
          name: name,
          detailsPlace: detailsPlace,
          category: category,
          fileTour: fileTour,
          galleries: galleries,
          latitude: latitude,
          longitude: longitude);

      Navigator.of(context).pop(); // ปิด AlertDialog ที่แสดงสถานะการดำเนินการ

      print(resp);
      if (resp == 'success') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Place created successfully!'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Tourist Attractions'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    _imageTour != null
                        ? Container(
                            height: 200,
                            width: 300,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: MemoryImage(_imageTour!),
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
                  'Place Name',
                  style: heading3,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, top: 5),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Name',
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  'Category',
                  style: heading3,
                ),
              ),
              _selectedCategory != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text('Selected Category: $_selectedCategory'),
                    )
                  : Container(),
              Container(
                padding: EdgeInsets.only(left: 10, top: 5, bottom: 10),
                child: DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  },
                  items: <String>[
                    'Cafe',
                    'Culture',
                    'Landmark',
                    'Shopping',
                    'Food&Drinks',
                    'Nature',
                    // Add more categories as needed
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    hintText: 'Select Category',
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Select gallery',
                  style: heading3,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
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
              // Address google map
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Address',
                      style: heading3,
                    ),
                    Text(
                      'Add the details of place',
                      style: p2,
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: detailscontroller,
                  decoration: const InputDecoration(
                    hintText: 'ex.no 9 moo 9 ,Bandoo Sub-dist, Meung District',
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ), // Address google map
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Latitude , longitude (option)',
                      style: heading3,
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: latitudeController,
                      decoration: const InputDecoration(
                        hintText: 'lat',
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                    TextField(
                      controller: longitudeController,
                      decoration: const InputDecoration(
                        hintText: 'lng',
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Center(
                child: ElevatedButton(
                  onPressed: savePlace,
                  child: const Text(
                    'SavePlace',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
