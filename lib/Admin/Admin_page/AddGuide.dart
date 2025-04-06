import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patour_firebase02/Admin/Admin_page/utils.dart';
import 'package:patour_firebase02/Resource/add_data_guide.dart';
import 'package:patour_firebase02/utils/style.dart';

class AddGuide extends StatefulWidget {
  const AddGuide({super.key});

  @override
  State<AddGuide> createState() => _AddGuideState();
}

class _AddGuideState extends State<AddGuide> {
  Uint8List? _imageGuide;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactEmailController = TextEditingController();
  final TextEditingController contactTelController = TextEditingController();  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _imageGuide = img;
    });
  }


  void saveGuide() async {
  String name = nameController.text;
  Uint8List imageGuide = _imageGuide!;
  String contactEmail = contactEmailController.text;
  String contactTel = contactTelController.text;




  if (name != null && name.isNotEmpty) {
    // แสดงสถานะการดำเนินการ
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Saving Guide...'),
              SizedBox(height: 16.0),
              CircularProgressIndicator(),
            ],
          ),
        );
      },
    );

    String resp = await StoredData().saveData(
        name: name,
        contactEmail:contactEmail,contactTel : contactTel,
        imageGuide:imageGuide,
      );
    Navigator.of(context).pop(); // ปิด AlertDialog ที่แสดงสถานะการดำเนินการ

    print(resp);
    if (resp == 'success') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Save Guide Successfully!'),
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
        appBar: AppBar(title: Text('Add Guide')),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    _imageGuide != null
                        ? Container(
                            height: 200,
                            width: 300,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: MemoryImage(_imageGuide!),
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
              //Add Name
              Container(padding: EdgeInsets.all(10), 
              child: Text('Add Guide Name' ,style: heading3,),),
              Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Name',
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
         
              //Add Contact : email
              Container(padding: EdgeInsets.all(10), 
              child: Text('E-mail' ,style: heading3,),),
              Container(
                 padding: EdgeInsets.only(left: 10,right: 10),
                child: TextField(
                  controller: contactEmailController,
                  decoration: const InputDecoration(
                    hintText: 'E-mail',
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              //Add Contact : tel
              Container(padding: EdgeInsets.all(10), 
              child: Text('Tel Number' ,style: heading3,),),
              Container(
                 padding: EdgeInsets.only(left: 10,right: 10),
                child: TextField(
                  controller: contactTelController,
                  decoration: const InputDecoration(
                    hintText: 'Tel.000-000-0000',
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
             SizedBox(height: 10,),
              Center(
                child: ElevatedButton(
                  onPressed: saveGuide,
                  child: const Text('Save'),
                ),
              ),
              
            ],
          ),
        )));
  }
}
