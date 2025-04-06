import 'package:flutter/material.dart';

import 'package:patour_firebase02/Admin/Admin_page/ManageGuide.dart';
import 'package:patour_firebase02/Admin/Admin_page/ManageHotel_page.dart';
import 'package:patour_firebase02/Admin/Admin_page/ManageTour.dart';
import 'package:patour_firebase02/User_page/homePage.dart';
import 'package:patour_firebase02/utils/style.dart';

class AddPlaceMain extends StatelessWidget {
  const AddPlaceMain({Key? key});
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( actions: [IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                (Route<dynamic> route) =>
                    false, // เมื่อกดปุ่ม home ให้ลบเส้นทางเดิมทั้งหมดออกจาก stack
              );
            },
          ),],),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.white),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add Information',
                        style: heading1,
                      ),
                      Text(
                        'Admin only',
                        style: p1,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ManageTour()),
                        );
                      },
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(
                            color: Color.fromARGB(95, 30, 153, 149),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'accest/images/landmark.png',
                              width: 100,
                              height: 100,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Tourist Attraction',
                              style: p2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ManageHotel()),
                        );
                      },
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(
                            color: Color.fromARGB(95, 30, 153, 149),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'accest/images/hotel.png',
                              width: 100,
                              height: 100,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Hotel',
                              style: p2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ManageGuide()),
                        );
                      },
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(
                            color: Color.fromARGB(95, 30, 153, 149),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'accest/images/guide.png',
                              width: 100,
                              height: 100,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Guide',
                              style: p2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    
    );
  }
  

  
}

