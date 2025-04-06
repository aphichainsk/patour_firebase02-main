import 'package:flutter/material.dart';
import 'package:patour_firebase02/Admin/Admin_page/AddPlace.dart';

class AddPlaceUser
 extends StatelessWidget {
   AddPlaceUser({super.key});

  TextEditingController adminCode = TextEditingController();
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add place'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Only admin can add place'),
              Text('Enter admin code'),
              Container(
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: adminCode,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (adminCode.text == 'admin00994567u') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddPlaceMain(),
                      ),
                    );
                  }
                },
                child: Text('Enter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
