import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:patour_firebase02/Resource/DataProvider.dart';
import 'package:patour_firebase02/Admin/Admin_page/addtouristAtt.dart';

class ManageTour extends StatefulWidget {
  @override
  _ManageTourState createState() => _ManageTourState();
}

class _ManageTourState extends State<ManageTour> {
  String _selectedCategory = '';

  void _deleteData(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('tour')
          .doc(documentId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Data deleted successfully!'),
      ));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to delete data: $error'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Tourist Attraction'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddtouristAtt()),
              );
            },
          ),
          PopupMenuButton(
            onSelected: (value) {
              setState(() {
                _selectedCategory = value;
              });
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'Cafe',
                child: Text('Cafe'),
              ),
              PopupMenuItem(
                value: 'Culture',
                child: Text('Culture'),
              ),
              PopupMenuItem(
                value: 'Landmark',
                child: Text('Landmark'),
              ),
              PopupMenuItem(
                value: 'Shopping',
                child: Text('Shopping'),
              ),
              PopupMenuItem(
                value: 'Food&Drinks',
                child: Text('Food&Drinks'),
              ),
              PopupMenuItem(
                value: 'Nature',
                child: Text('Nature'),
              ),
            ],
          ),
        ],
      ),
      body: StreamBuilder<List<YourDataModel>>(
        stream: YourDataProvider().getData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<YourDataModel> data = snapshot.data!;

          // กรองข้อมูลตาม Category ที่เลือก
          if (_selectedCategory.isNotEmpty) {
            data = data
                .where((item) => item.category == _selectedCategory)
                .toList();
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(8.0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          data[index].imageUrlTour,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          data[index].name,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // เรียกใช้ฟังก์ชันเพื่อลบข้อมูล
                      _deleteData(data[index].documentId);
                    },
                    child: Text('Delete'),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
