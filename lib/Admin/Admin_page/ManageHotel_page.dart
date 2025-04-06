import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:patour_firebase02/Admin/Admin_page/Addhotel.dart';
import 'package:patour_firebase02/Resource/Data_Provider_Hotel.dart';

class ManageHotel extends StatefulWidget {
  @override
  _ManageHotelState createState() => _ManageHotelState();
}

class _ManageHotelState extends State<ManageHotel> {


void _deleteData(String documentId) async {
  try {
    await FirebaseFirestore.instance.collection('hotel').doc(documentId).delete();
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
        title: Text('Manage Hotel'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddHotel()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<YourDataModelHotel>>(
        stream: YourDataProviderHotel().getData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<YourDataModelHotel> data = snapshot.data!;



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
                          data[index].imageLinkHotel,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          data[index].name,
                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
