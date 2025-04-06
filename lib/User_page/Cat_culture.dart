import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:patour_firebase02/ShowDataForUser/DataProvider_cafe.dart';
import 'package:patour_firebase02/User_page/homePage.dart';
import 'package:patour_firebase02/utils/style.dart';

class CategoryCulture extends StatefulWidget {
  @override
  _CategoryCultureState createState() => _CategoryCultureState();
}

class _CategoryCultureState extends State<CategoryCulture> {
  String _selectedCategory = 'Culture';

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
        title: Text('Culture',style: heading1,),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              setState(() {
                _selectedCategory = value;
              });
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'Culture',
                child: Text('Culture'),
              ),
            ],
          ),
        ],
      ),
      body: StreamBuilder<List<YourDataModelCafeDetails>>(
        stream: YourDataProviderCafe().getDataDetails(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<YourDataModelCafeDetails> dataCafe = snapshot.data!;

          // Filter data by selected category
          dataCafe = dataCafe
              .where((item) => item.category == _selectedCategory)
              .toList();

          return ListView.builder(
            itemCount: dataCafe.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate to detail page when pressed on the card
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(YourDataModelCafeDetails(
                            imageUrlTour: dataCafe[index].imageUrlTour,
                            name: dataCafe[index].name,
                            category: dataCafe[index].category,
                            detailsPlace: dataCafe[index]
                                .detailsPlace, // ต้องเติมข้อมูลให้ตรงกับ YourDataModelCafeDetails
                            galleries: dataCafe[index]
                                .galleries, // ต้องเติมข้อมูลให้ตรงกับ YourDataModelCafeDetails
                            latitude: dataCafe[index]
                                .latitude, // ต้องเติมข้อมูลให้ตรงกับ YourDataModelCafeDetails
                            longitude: dataCafe[index]
                                .longitude, // ต้องเติมข้อมูลให้ตรงกับ YourDataModelCafeDetails
                          )),
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
                            dataCafe[index].imageUrlTour,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            dataCafe[index].name,
                            style: heading1,
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

class DetailPage extends StatelessWidget {
  final YourDataModelCafeDetails dataCafeDetails;

  const DetailPage(this.dataCafeDetails, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dataCafeDetails.name,style: heading1,),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display image
            Image.network(
              dataCafeDetails.imageUrlTour,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),

            SizedBox(height: 10,),
            // Display name
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 5),
              child: Text(
                dataCafeDetails.name,
                style: heading1,
              ),
            ),
            // Display category
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Category: ${dataCafeDetails.category}',
                style: p1,
              ),
            ),
            // Display details
            Container(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                  Text(
                    'Details',
                    style: heading3,
                  ),
                  Text(
                    '${dataCafeDetails.detailsPlace}',
                    style: p1,
                  )
                ]),
              ),
            ),
            // Display gallery images

            if (dataCafeDetails.galleries.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gallery',
                      style:
                          heading3,
                    ),
                    SizedBox(height: 8),
                    Container(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: dataCafeDetails.galleries.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.network(
                              dataCafeDetails.galleries[
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

            // Display location

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Location',
                    style: heading3,
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 200,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(dataCafeDetails.latitude,
                            dataCafeDetails.longitude),
                        zoom: 15,
                      ),
                      markers: {
                        Marker(
                          markerId: MarkerId(dataCafeDetails.name),
                          position: LatLng(dataCafeDetails.latitude,
                              dataCafeDetails.longitude),
                        ),
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
