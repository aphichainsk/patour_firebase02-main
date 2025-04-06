import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:patour_firebase02/ShowDataForUser/DataProvider_cafe.dart';
import 'package:patour_firebase02/utils/style.dart';
class CardListTour extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<YourDataModelCafeDetails>>(
      stream: YourDataProviderCafe().getDataDetails(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<YourDataModelCafeDetails> data = snapshot.data!;

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navigate to detail page here
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailPage(YourDataModelCafeDetails(
                          imageUrlTour: data[index].imageUrlTour,
                          name: data[index].name,
                          category: data[index].category,
                          detailsPlace: data[index]
                              .detailsPlace, // ต้องเติมข้อมูลให้ตรงกับ YourDataModelCafeDetails
                          galleries: data[index]
                              .galleries, // ต้องเติมข้อมูลให้ตรงกับ YourDataModelCafeDetails
                          latitude: data[index]
                              .latitude, // ต้องเติมข้อมูลให้ตรงกับ YourDataModelCafeDetails
                          longitude: data[index]
                              .longitude, // ต้องเติมข้อมูลให้ตรงกับ YourDataModelCafeDetails
                        )),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Container(
                  width: 180,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                     gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.3), // Darken color
                              Colors.transparent,
                            ],
                          ),
                    
                    image: DecorationImage(
                      image: NetworkImage(data[index].imageUrlTour),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3), // Adjust opacity as needed
                        BlendMode.darken,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          data[index].name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}






class TourCardMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tour Cards'),
        // ไม่ต้องการให้มีปุ่ม back ในหน้านี้
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            CardListTour(),
            // เพิ่ม CardListHotel อื่น ๆ ตามต้องการ
            // CardListHotel(selectedCategory: 'Cafe'),
            // CardListHotel(selectedCategory: 'Culture'),
            // และอื่น ๆ
          ],
        ),
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
