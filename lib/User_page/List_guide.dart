import 'package:flutter/material.dart';
import 'package:patour_firebase02/ShowDataForUser/DataProvider_guide.dart';
import 'package:patour_firebase02/User_page/homePage.dart';
import 'package:patour_firebase02/utils/style.dart';

class ListGuide extends StatefulWidget {
  const ListGuide({Key? key}) : super(key: key);

  @override
  State<ListGuide> createState() => _ListGuideState();
}

class _ListGuideState extends State<ListGuide> {
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
          'Tour Buddy',
          style: heading1,
        ),
      ),
      body: StreamBuilder<List<YourDataModelGuideDetails>>(
        stream: YourDataProviderGuide().getDataDetails(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<YourDataModelGuideDetails> dataGuide = snapshot.data!;

          return ListView.builder(
            itemCount: dataGuide.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailPageGuide(dataGuide[index]),
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
                            dataGuide[index].imageUrlGuide,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            dataGuide[index].name,
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

class DetailPageGuide extends StatelessWidget {
  final YourDataModelGuideDetails dataGuideDetails;

  const DetailPageGuide(this.dataGuideDetails, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          dataGuideDetails.name,
          style: heading1,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display image
            Image.network(
              dataGuideDetails.imageUrlGuide,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 10,
            ),
            // Display name
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 5),
              child: Text(
                dataGuideDetails.name,
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
                        'Contacts',
                        style: heading3,
                      ),
                      Text(
                        'Email : ${dataGuideDetails.contactEmail}',
                        style: p1,
                      ),
                      Text(
                        'Tel : ${dataGuideDetails.contactTel}',
                        style: p1,
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
