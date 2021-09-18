import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'package:skrrt_app/appbar-ridebutton/ride_button.dart';
import 'package:skrrt_app/appbar-ridebutton/skrrt-appbar.dart';
import 'sidebar_page.dart';

import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;


class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var session = FlutterSession();

  var _month = ['Jan','Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec' ];
  var _currentMonthSelected = 'Dec';
  var _currentMonthSelected1 = 'Dec';

  String earnings = "0", earnIncrease = "0", successfulRides = "0", rideIncrease = "0";
  double
      successfulRideRate = 90.12,

      responses = 102,
      responseRate,
      totalSkrrtDistance = 1524;
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void viewRevenue() async{

    var url = "http://192.168.1.17/skrrt/viewRevenue.php";
    var data = {
      "month": _currentMonthSelected,
    };

    var res = await http.post(url,body: data);

    List userData = await jsonDecode(res.body);
    earnings = userData[0]['revenue'].toString();
    earnings += ".00";

    earnIncrease = userData[1]['last'].toString();
    earnIncrease += ".00";
    print(userData[1]['last'].toString());
    setState(() {});
  }

  void viewRides() async{

    var url = "http://192.168.1.17/skrrt/viewRides.php";
    var data = {
      "month": _currentMonthSelected1,
    };

    var res = await http.post(url,body: data);

    List userData = await jsonDecode(res.body);
    print(userData[0]['rides'].toString());
    successfulRides = userData[0]['rides'].toString();
    rideIncrease = userData[1]['last'].toString();
    print(userData[1]['last'].toString());
    setState(() {});
  }

  void initState(){
    super.initState();
    viewRevenue();
    viewRides();
    setState(() {});
  }

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
                height: MediaQuery.of(context).size.height * 0.30+5,
                //color: Colors.lightBlue,
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                        children:[
                          Text(
                              "Summary ",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Quicksand"
                              )
                          ),
                          Icon(
                              Icons.bar_chart,
                              color: Colors.lightBlue
                          )
                        ]
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(0,10,0,0),
                        padding: EdgeInsets.all(2),
                        height: MediaQuery.of(context).size.height * 0.20,
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Color(0xff48CEFF),
                                  ),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:[
                                        Icon(Icons.arrow_circle_up_outlined,
                                            color: Colors.lightGreen),
                                        Text(
                                            "90.12%",
                                            style: TextStyle(
                                                fontSize:17,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Quicksand"
                                            )
                                        ),
                                        Text(
                                          "10,234",
                                          style: TextStyle(
                                              fontSize:15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontFamily: "Quicksand"
                                          ),
                                        ),
                                        Text(
                                            "Successful",
                                            style: TextStyle(
                                                fontSize:13,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontFamily: "Quicksand"
                                            )
                                        ),
                                        Text(
                                            "Rides",
                                            style: TextStyle(
                                                fontSize:13,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontFamily: "Quicksand"
                                            )
                                        )
                                      ]
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Color(0xff1CC2FF),
                                  ),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:[
                                        Icon(Icons.arrow_circle_up_outlined,
                                            color: Colors.green),
                                        Text(
                                            "70.01%",
                                            style: TextStyle(
                                                fontSize:17,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Quicksand"
                                            )
                                        ),
                                        Text(
                                            "10,234",
                                            style: TextStyle(
                                                fontSize:15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontFamily: "Quicksand"
                                            )
                                        ),
                                        Text(
                                            "Response",
                                            style: TextStyle(
                                                fontSize:13,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontFamily: "Quicksand"
                                            )
                                        ),
                                        Text(
                                            "Rate",
                                            style: TextStyle(
                                                fontSize:13,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontFamily: "Quicksand"
                                            )
                                        )

                                      ]
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Color(0xff00A8E5),
                                    ),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:[
                                          Icon(Icons.arrow_circle_up_outlined,
                                              color: Colors.green),
                                          Text(
                                              "20.12%",
                                              style: TextStyle(
                                                  fontSize:17,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Quicksand"
                                              )
                                          ),
                                          Text(
                                              "255",
                                              style: TextStyle(
                                                  fontSize:15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontFamily: "Quicksand"
                                              )
                                          ),
                                          Text(
                                              "Happy",
                                              style: TextStyle(
                                                  fontSize:13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontFamily: "Quicksand"
                                              )
                                          ),
                                          Text(
                                              "Feedback",
                                              style: TextStyle(
                                                  fontSize:13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontFamily: "Quicksand"
                                              )
                                          )

                                        ]
                                    ),
                                  ),
                              )
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
                height: 205,
                //color: Colors.lightBlue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                        children:[
                          Text(
                              "Earnings ",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Quicksand"
                              )
                          ),
                          Icon(
                              Icons.attach_money_rounded,
                              color: Colors.green
                          )
                        ]
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
                                      fontSize:MediaQuery.of(context).size.width * 0.04,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  DropdownButton<String>(
                                    underline: Container(
                                      height: 2,
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontSize:MediaQuery.of(context).size.width * 0.04,
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
                                         _currentMonthSelected = newMonthSelected;
                                      });
                                      viewRevenue();
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
                                  if(_currentMonthSelected=='Nov')
                                  Text(
                                    '₱2000.00',
                                    style: TextStyle(
                                      //color: Color(0xFF05C853),
                                        fontFamily: "Quicksand",
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  if(_currentMonthSelected=='Dec')
                                    Text(
                                      '₱3000.00',
                                      style: TextStyle(
                                        //color: Color(0xFF05C853),
                                          fontFamily: "Quicksand",
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  if(_currentMonthSelected!='Nov'&&_currentMonthSelected!='Dec')
                                    Text(
                                      'N/A',
                                      style: TextStyle(
                                        //color: Color(0xFF05C853),
                                          fontFamily: "Quicksand",
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  Text(
                                    '+'+'₱'+ earnIncrease,
                                    style: TextStyle(
                                        color: Color(0xFF05C853),
                                        fontFamily: "Quicksand",
                                        fontSize: 14,
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
                height: 205,
                //color: Colors.lightBlue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                        children:[
                          Text(
                              "Rides ",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Quicksand"
                              )
                          ),
                          Icon(
                              Icons.electric_scooter ,
                              color: Colors.blue
                          )
                        ]
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
                                      fontSize:MediaQuery.of(context).size.width * 0.04,
                                    ),
                                  ),
                                  DropdownButton<String>(
                                    underline: Container(
                                      height: 2,
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontSize:MediaQuery.of(context).size.width * 0.04,
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
                                        this. _currentMonthSelected1 = newMonthSelected;
                                        //print(_currentMonthSelected1);
                                      });
                                      viewRides();
                                    },
                                    value: _currentMonthSelected1,
                                  ),
                                ],
                              )
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 12),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  if(_currentMonthSelected1=='Nov')
                                  Text(
                                    '₱10000.00',
                                    style: TextStyle(
                                      //color: Color(0xFF05C853),
                                      fontFamily: "Quicksand",
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if(_currentMonthSelected1=='Dec')
                                    Text(
                                      '₱20000.00',
                                      style: TextStyle(
                                        //color: Color(0xFF05C853),
                                        fontFamily: "Quicksand",
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  if(_currentMonthSelected1!='Nov'&&_currentMonthSelected1!='Dec')
                                    Text(
                                      'N/A',
                                      style: TextStyle(
                                        //color: Color(0xFF05C853),
                                        fontFamily: "Quicksand",
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  Text(
                                    '+'+ rideIncrease,
                                    style: TextStyle(
                                      color: Color(0xFF05C853),
                                      fontFamily: "Quicksand",
                                      fontSize: 14,
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.electric_scooter),
            label: 'Scooters',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),

      floatingActionButton: RideButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }
}