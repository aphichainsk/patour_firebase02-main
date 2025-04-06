import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:patour_firebase02/ShowDataForUser/DataProvider_cafe.dart';
import 'package:patour_firebase02/User_page/homePage.dart';
import 'package:patour_firebase02/utils/style.dart';

class SearchPlace extends StatefulWidget {
  const SearchPlace({Key? key}) : super(key: key);

  @override
  State<SearchPlace> createState() => _SearchPlaceState();
}

class _SearchPlaceState extends State<SearchPlace> {
  TextEditingController _searchController = TextEditingController();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _allResults = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _resultsList = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _getAllTours();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    var showResults = [];

    if (_searchController.text != "") {
      for (var tourSnapshot in _allResults) {
        var name = tourSnapshot.data()['name'].toLowerCase();

        if (name.contains(_searchController.text.toLowerCase())) {
          showResults.add(tourSnapshot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultsList = showResults.cast<QueryDocumentSnapshot<Map<String, dynamic>>>();
    });
  }

  _getAllTours() async {
    var data = await FirebaseFirestore.instance.collection('tour').get();
    setState(() {
      _allResults = data.docs.map((doc) => doc as QueryDocumentSnapshot<Map<String, dynamic>>).toList();
    });
    searchResultsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tour Search",style: heading1,),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search by name...",
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: _resultsList.isEmpty
                ? _buildNoResultsWidget()
                : ListView.builder(
                    itemCount: _resultsList.length,
                    itemBuilder: (BuildContext context, int index) =>
                        buildTourCard(context, _resultsList[index]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResultsWidget() {
    return Center(
      child: Text(
        'Not found',
        style: TextStyle(fontSize: 20,  ),
      ),
    );
  }

  Widget buildTourCard(BuildContext context, QueryDocumentSnapshot<Map<String, dynamic>> tourSnapshot) {
    YourDataModelCafeDetails tourData = YourDataModelCafeDetails.fromFirestore(tourSnapshot);
    
    return ListTile(
      title: Text(tourData.name),
      subtitle: Text(tourData.detailsPlace),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage(tourData)),
        );
      },
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
        title: Text(
          dataCafeDetails.name,
          style: heading1,
        ),
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
            // Display name
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 5,top: 10),
              child: Text(
                dataCafeDetails.name,
                style: heading3,
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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      style: heading3,
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
                              dataCafeDetails.galleries[index],
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
                        target: LatLng(dataCafeDetails.latitude, dataCafeDetails.longitude),
                        zoom: 15,
                      ),
                      markers: {
                        Marker(
                          markerId: MarkerId(dataCafeDetails.name),
                          position: LatLng(dataCafeDetails.latitude, dataCafeDetails.longitude),
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
