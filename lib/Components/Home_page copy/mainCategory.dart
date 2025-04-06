import 'package:flutter/material.dart';
import 'package:patour_firebase02/User_page/Cat_Landmark.dart';
import 'package:patour_firebase02/User_page/Cat_cafe.dart';
import 'package:patour_firebase02/User_page/Cat_culture.dart';
import 'package:patour_firebase02/User_page/Cat_food.dart';
import 'package:patour_firebase02/User_page/Cat_nature.dart';
import 'package:patour_firebase02/User_page/Cat_shopping.dart';
import 'package:patour_firebase02/utils/style.dart';


class MainCategory extends StatelessWidget {
  const MainCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15,),
        Label(),
        SizedBox(
          height: 10,
        ),

        Row(
          children: [
            Category_Cafe(context),
            SizedBox(
              width: 10,
            ),
            Category_Culture(context),
            SizedBox(
              width: 10,
            ),
            Category_Landmark(context)
          ],
        ),SizedBox(height: 10,),
        Row(
          children: [
            Category_Shopping(context),
             SizedBox(
              width: 10,
            ),
            Category_Food(context),
             SizedBox(
              width: 10,
            ),
            Category_Nature(context)
          ],
        ) // corrected function call
      ],
    );
  }

  Widget Label() {
    return Row(
      
      children: [
        Text('Category', style: heading1),
      ],
    );
  }

  Widget Category_Landmark(BuildContext context) {
    // function name corrected
    return GestureDetector(
      onTap: () {
        // Navigate to the landmark page here
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CategoryLandmark()),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          Container(
            height: 85,
            width: 85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: accent,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.all(10)),
                Container(child: Image.asset('accest/images/landmark.png'),height: 40,width: 40,),
                Center(
                  child: Text('Landmark',style: p4,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget Category_Culture(BuildContext context) {
    // function name corrected
    return GestureDetector(
      onTap: () {
        // Navigate to the landmark page here
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CategoryCulture()),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          Container(
            height: 85,
            width: 85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: accent,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.all(10)),
                Container(child: Image.asset('accest/images/church.png'),height: 40,width: 40,),
                Center(
                  child: Text('Culture',style: p4,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget Category_Cafe(BuildContext context) {
    // function name corrected
    return GestureDetector(
      onTap: () {
        // Navigate to the landmark page here
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CategoryCafe()),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          Container(
            height: 85,
            width: 85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: accent,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.all(10)),
                Container(child: Image.asset('accest/images/cafe.png'),height: 40,width: 40,),
                Center(
                  child: Text('Cafe',style: p4,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget Category_Nature(BuildContext context) {
    // function name corrected
    return GestureDetector(
      onTap: () {
        // Navigate to the landmark page here
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CategoryNature()),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          Container(
            height: 85,
            width: 85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: accent,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.all(10)),
                Container(child: Image.asset('accest/images/planet-earth.png'),height: 40,width: 40,),
                Center(
                  child: Text('Nature',style: p4,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget Category_Shopping(BuildContext context) {
    // function name corrected
    return GestureDetector(
      onTap: () {
        // Navigate to the landmark page here
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CategoryShop()),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          Container(
            height: 85,
            width: 85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: accent,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.all(10)),
                Container(child: Image.asset('accest/images/online-shopping.png'),height: 40,width: 40,),
                Center(
                  child: Text('Shopping',style: p4,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget Category_Food(BuildContext context) {
    // function name corrected
    return GestureDetector(
      onTap: () {
        // Navigate to the landmark page here
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CategoryFood()),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          Container(
            height: 85,
            width: 85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: accent,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.all(10)),
                Container(child: Image.asset('accest/images/fast-food.png'),height: 40,width: 40,),
                Center(
                  child: Text('Food&Drinks',style: p4,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
