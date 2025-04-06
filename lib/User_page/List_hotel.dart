import 'package:flutter/material.dart';
import 'package:patour_firebase02/ShowDataForUser/DataProvider_hotel.dart';
import 'package:patour_firebase02/User_page/homePage.dart';
import 'package:patour_firebase02/utils/style.dart';

class ListHotel extends StatefulWidget {
  const ListHotel({Key? key}) : super(key: key);

  @override
  State<ListHotel> createState() => _ListHotelState();
}

class _ListHotelState extends State<ListHotel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (Route<dynamic> route) => false,
            );
          },
        ),
       
        title: Text(
          'Hotel',
          style: heading1,
        ),
      ),
      body: StreamBuilder<List<YourDataModelHotelDetails>>(
        stream: YourDataProviderHotel().getDataDetails(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<YourDataModelHotelDetails> dataHotel = snapshot.data!;

          return ListView.builder(
            itemCount: dataHotel.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailPageHotel(dataHotel[index]),
                        ),
                      );
                    },
                    child: Container(
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
                            dataHotel[index].imageUrlHotel,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            dataHotel[index].name,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class DetailPageHotel extends StatelessWidget {
  final YourDataModelHotelDetails dataHotelDetails;

  const DetailPageHotel(this.dataHotelDetails, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          dataHotelDetails.name,
          style: heading1,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display image
            Image.network(
              dataHotelDetails.imageUrlHotel,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10,),
            // Display name
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 5),
              child: Text(
                dataHotelDetails.name,
                style: heading1,
              ),
            ),

            // Display details
            Container(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price/day',
                        style: heading3,
                      ),
                      Text(
                        '${dataHotelDetails.price}',
                        style: p1,
                      )
                    ]),
              ),
            ),

            // Display Contact
            Container(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact',
                        style: heading3,
                      ),
                      Text(
                        'Email : ${dataHotelDetails.contactEmail}',
                        style: p1,
                      ),
                      Text(
                        'Tel : ${dataHotelDetails.contactTel}',
                        style: p1,
                      )
                    ]),
              ),
            ),

             // Display Address
            Container(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Address',
                        style: heading3,
                      ),
                      Text(
                        '${dataHotelDetails.address}',
                        style: p1,
                      )
                    ]),
              ),
            ),
            // Display gallery images

            if (dataHotelDetails.galleries.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gallery',
                      style: heading3,
                    ),
                    SizedBox(height: 8),
                    Container(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: dataHotelDetails.galleries.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.network(
                              dataHotelDetails.galleries[
                                  index], // ใช้ URL จาก dataCafeDetails
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
