import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:skrrt_app/appbar-ridebutton/ride_button.dart';
import 'package:skrrt_app/appbar-ridebutton/skrrt-appbar.dart';
import 'sidebar_page.dart';

class PastRides extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _buildRideWidget(String name, int distance, int seconds, int amount,String date){
    var _color,_color2;
    double min = seconds/60;
    int mins = min.toInt();
    int secs = (seconds - (60*mins)) ;
    //String dist = distance.toString() + "km";

    _color = 0xFFE7E7E7;
    _color2 = 0xFF7D7D7D;

    return Container(
      margin: EdgeInsets.fromLTRB(30,12,20,12),
      padding: EdgeInsets.all(10),
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Color(_color),
      ),
      child: Row(
        children: <Widget>[
          Container(
            //width: double.infinity,
            height: 100,
            padding: EdgeInsets.all(5.0),
            child: Center(
              child: Image(
                width: 80,
                height: 80,
                image: AssetImage('assets/scooter-sample-img.png'),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  //width: 200,
                  //color: Colors.red,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text(
                          name,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          date,
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(_color2),
                            fontFamily: 'Quicksand',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top:4),
                        height: 50,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "$distance km",
                                style: TextStyle(
                                  fontFamily: 'QuickSand',
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "travelled",
                                style: TextStyle(
                                  color: Color(0xFf7D7D7D),
                                  fontSize: 12,
                                  fontFamily: 'Quicksand',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top:4),
                        height: 50,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "$mins:$secs",
                                style: TextStyle(
                                  fontFamily: 'QuickSand',
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "time",
                                style: TextStyle(
                                  color: Color(0xFf7D7D7D),
                                  fontSize: 12,
                                  fontFamily: 'Quicksand',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top:4),
                        height: 50,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "₱$amount",
                                style: TextStyle(
                                  fontFamily: 'QuickSand',
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "amount",
                                style: TextStyle(
                                  color: Color(0xFf7D7D7D),
                                  fontSize: 12,
                                  fontFamily: 'Quicksand',
                                ),
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
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          backgroundColor: Colors.white10,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.menu),
            color: Colors.black,
            onPressed: (){
              _scaffoldKey.currentState.openDrawer();
            },
          ),
        flexibleSpace: AppbarImage(),
      ),
      drawer:  SideBar(),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Past Rides',
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            _buildRideWidget('Phoenix', 20, 230, 30, '10-20-2020'),
            _buildRideWidget('Sage', 25, 350, 35, '08-15-2020'),
            _buildRideWidget('Reyna', 3, 181, 25, '08-13-2020'),
            _buildRideWidget('Jett', 2, 350, 40, '07-07-2020'),
            _buildRideWidget('Raze', 4, 350, 40, '06-09-2020'),
          ],
        ),
      ),
      floatingActionButton: RideButton(),
    );
  }
}