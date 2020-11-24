import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'package:skrrt_app/appbar-ridebutton/ride_button.dart';
import 'package:skrrt_app/appbar-ridebutton/skrrt-appbar.dart';
import 'sidebar_page.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var _month = ['January','February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December' ];
  var _currentMonthSelected = 'March';
  double
      earnings = 25252.00,
      earnIncrease = 253.00,
      successfulRideRate = 90.12,
      successfulRides = 10234,
      responses = 102,
      responseRate,
      rideIncrease = 150,
      totalSkrrtDistance = 1524;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: 200,
                //color: Colors.lightBlue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        "Analytics",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Quicksand"
                        )
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0,10,0,0),
                      padding: EdgeInsets.all(2),
                      width: double.infinity,
                      height: 140,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.lightBlueAccent,
                              ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Icon(Icons.arrow_circle_up_outlined,
                                color: Colors.lightGreen),
                                Text(
                                  "90.12%",
                                  style: TextStyle(
                                    fontSize:18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Quicksand"
                                  )
                                ),
                                Text(
                                    "10,234",
                                    style: TextStyle(
                                        fontSize:12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: "Quicksand"
                                    )
                                ),
                                Text(
                                    "Successful",
                                    style: TextStyle(
                                        fontSize:14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontFamily: "Quicksand"
                                    )
                                ),
                                Text(
                                    "Rides",
                                    style: TextStyle(
                                        fontSize:14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontFamily: "Quicksand"
                                    )
                                )

                              ]
                          ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.lightBlue,
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  Icon(Icons.arrow_circle_up_outlined,
                                      color: Colors.green),
                                  Text(
                                      "70.01%",
                                      style: TextStyle(
                                          fontSize:18,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Quicksand"
                                      )
                                  ),
                                  Text(
                                      "10,234",
                                      style: TextStyle(
                                          fontSize:12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: "Quicksand"
                                      )
                                  ),
                                  Text(
                                      "Response",
                                      style: TextStyle(
                                          fontSize:14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontFamily: "Quicksand"
                                      )
                                  ),
                                  Text(
                                      "Rate",
                                      style: TextStyle(
                                          fontSize:14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontFamily: "Quicksand"
                                      )
                                  )

                                ]
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.blueAccent,
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  Icon(Icons.arrow_circle_up_outlined,
                                      color: Colors.green),
                                  Text(
                                      "20.12%",
                                      style: TextStyle(
                                          fontSize:18,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Quicksand"
                                      )
                                  ),
                                  Text(
                                      "255",
                                      style: TextStyle(
                                          fontSize:12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: "Quicksand"
                                      )
                                  ),
                                  Text(
                                      "Happy",
                                      style: TextStyle(
                                          fontSize:14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontFamily: "Quicksand"
                                      )
                                  ),
                                  Text(
                                      "Feedback",
                                      style: TextStyle(
                                          fontSize:14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontFamily: "Quicksand"
                                      )
                                  )

                                ]
                            ),
                          ),
                        ]
                      )
                    ),

                  ],
                )
            ),
            Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: 200,
                //color: Colors.lightBlue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        "Earnings",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Quicksand"
                        )
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      width: double.infinity,
                      height: 125,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0xFFE7E7E7),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            //color: Colors.red,
                              height: 50,
                              padding: EdgeInsets.all(12),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Earnings in ',
                                    style: TextStyle(
                                      fontFamily: "Quicksand",
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  DropdownButton<String>(
                                    underline: Container(
                                      height: 2,
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    items: _month.map((String dropDownStringItem) {
                                      return DropdownMenuItem<String>(
                                        value: dropDownStringItem,
                                        child: Text(dropDownStringItem),
                                      );
                                    }).toList(),
                                    onChanged: (String newMonthSelected){
                                      setState(() {
                                        this. _currentMonthSelected = newMonthSelected;
                                      });
                                    },
                                    value: _currentMonthSelected,
                                  ),
                                ],
                              )
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 12),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '₱'+earnings.toString(),
                                    style: TextStyle(
                                      //color: Color(0xFF05C853),
                                        fontFamily: "Quicksand",
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(
                                    '+'+'₱'+ earnIncrease.toString(),
                                    style: TextStyle(
                                        color: Color(0xFF05C853),
                                        fontFamily: "Quicksand",
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ]
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
            ),
            Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: 200,
                //color: Colors.lightBlue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        "Rides",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Quicksand"
                        )
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      width: double.infinity,
                      height: 125,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0xFFE7E7E7),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            //color: Colors.red,
                              height: 50,
                              padding: EdgeInsets.all(12),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Rides in ',
                                    style: TextStyle(
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  DropdownButton<String>(
                                    underline: Container(
                                      height: 2,
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    items: _month.map((String dropDownStringItem) {
                                      return DropdownMenuItem<String>(
                                        value: dropDownStringItem,
                                        child: Text(dropDownStringItem),
                                      );
                                    }).toList(),
                                    onChanged: (String newMonthSelected){
                                      setState(() {
                                        this. _currentMonthSelected = newMonthSelected;
                                      });
                                    },
                                    value: _currentMonthSelected,
                                  ),
                                ],
                              )
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 12),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    successfulRides.toString(),
                                    style: TextStyle(
                                      //color: Color(0xFF05C853),
                                        fontFamily: "Quicksand",
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '+'+ rideIncrease.toString(),
                                    style: TextStyle(
                                        color: Color(0xFF05C853),
                                        fontFamily: "Quicksand",
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
            ),
          ],
        ),
      ),
      floatingActionButton: RideButton(),

    );
  }
}