import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:skrrt_app/appbar-ridebutton/ride_button.dart';
import 'package:skrrt_app/appbar-ridebutton/skrrt-appbar.dart';
import 'package:skrrt_app/home_page.dart';
import 'package:skrrt_app/successful_ride_page.dart';
import 'sidebar_page.dart';

import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

double uniHeight(BuildContext context){
  if(MediaQuery.of(context).size.width<=600)
    return MediaQuery.of(context).size.height*0.1;
  else
    return MediaQuery.of(context).size.height*0.45;
}
double uniWidth(BuildContext context){
  if(MediaQuery.of(context).size.width<=600)
    return MediaQuery.of(context).size.width*0.1;
  else
    return MediaQuery.of(context).size.width*0.45;
}

class _PaymentPageState extends State<PaymentPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Color star1;
  Color star2;
  Color star3;
  Color star4;
  Color star5;
  String _balance = "₱";

  var session = FlutterSession();
  void viewBalance() async {
    //print("hello");
    var token = await session.get("token");
    var time = await session.get("time");

    print(token);
    var url = "http://192.168.1.4/skrrt/balance.php";
    var data = {
      "userID": token.toString(),
    };
    print(data);

    var res = await http.post(url,body:data);
    print(jsonDecode(res.body));

    List userData = await jsonDecode(res.body);
    _balance += userData[0]["balance"] += ".00";
    var _amount = time * 2 + 2;
    amount += _amount.toString();
    amount += ".00";
    print(_amount);
    //print("YES3");
    if(jsonDecode(res.body) == "okay"){
      print("YESSSSSSS");
    }
    else{
      print("NOOOOOO");
    }
    setState(() {});
  }
  String amount ="₱";

  void payRide() async {
    //print("hello");

    var time = await session.get("time");
    var _userID = await session.get("token");
    var _rideID = await session.get("rideID");

    print("hello");
    print(time);
    print(_rideID);
    print(time);

    var _amount = time * 2 + 2;
    print(_amount);

    var url = "http://192.168.1.4/skrrt/pay.php";  //localhost, change 192.168.1.9 to ur own localhost
    var data = {
      "rideID" : _rideID.toString(),
      "amount": _amount.toString(),
      "userID": _userID.toString(),
    };
    print(data);
    var res = await http.post(url,body:data);
    print(jsonDecode(res.body));
    //print("YES3");
    if(jsonDecode(res.body) == "okay"){
      print("YESSSSSSS");
    }
    else{
      print("NOOOOOO");
    }
  }

  void initState(){
    super.initState();
    star1 = Colors.grey;
    star2 = Colors.grey;
    star3 = Colors.grey;
    star4 = Colors.grey;
    star5 = Colors.grey;
    viewBalance();
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
                //color: Colors.lightBlue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.fromLTRB(0,10,0,0),
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        height: uniHeight(context)*3,
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.lightBlueAccent,
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:[
                            Text(
                                "Thank you for riding with us!",
                                style: TextStyle(
                                    fontSize:uniHeight(context)*.26,//13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "Quicksand"
                                )
                            ),
                            Text(
                                "\nAmount due:",
                                style: TextStyle(
                                    fontSize:uniHeight(context)*.25,//10,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Quicksand"
                                )
                            ),
                            Text(
                                amount,
                                style: TextStyle(
                                    fontSize:uniHeight(context)*.28,//22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: "Quicksand"
                                )
                            ),
                            Text(
                                "\nAvailable Skrrt Load Balance",
                                style: TextStyle(
                                    fontSize:uniHeight(context)*.25,//10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: "Quicksand"
                                )
                            ),
                            Text(
                                _balance,
                                style: TextStyle(
                                    fontSize:uniHeight(context)*.28,//22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: "Quicksand"
                                )
                            )
                          ]
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:[
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6, // match_parent
                              child: RaisedButton(
                                  padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.06, vertical: MediaQuery.of(context).size.height * 0.020),
                                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50.0)),
                                  textColor: Colors.white,
                                  color: Color(0xff00A8E5),
                                  child: Text('PAY NOW',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color:Colors.white,
                                      fontSize: uniHeight(context)*0.25,
                                    ),
                                  ),
                                  onPressed: () {
                                    payRide();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SuccessfulRide()),
                                    );
                                    /*
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Home()),
                                );*/
                                  }
                              ),
                          ),
/*
                          SizedBox(height: uniHeight(context)*.10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6, // match_parent
                            child: FlatButton(
                                padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.06, vertical: MediaQuery.of(context).size.height * 0.020),
                                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50.0), side: BorderSide(color: Color(0xff00A8E5))),
                                textColor: Color(0xff00A8E5),
                                color: Colors.white,
                                child: Text('PAY NOW',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color:Color(0xff00A8E5),
                                    fontSize: uniHeight(context)*0.25,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  /*
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Home()),
                                );*/
                                }
                            ),
                          ),*/
                          SizedBox(height: uniHeight(context)*.5),
                          Text(
                            "Rate Phoenix",
                              style: TextStyle(
                              fontSize:uniHeight(context)*.35,//15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Quicksand"
                          )
                          ),
                          SizedBox(height: uniHeight(context)*.5),
                          Image(
                              image: AssetImage('assets/scooter_phoenix.png'),
                              height: uniHeight(context)*1.5,//100,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:[
                              Container(
                                padding: const EdgeInsets.all(0.0),
                                width: 30.0, // you can adjust the width as you need
                                child: IconButton(
                                  icon: new Icon(Icons.star,),
                                  color: star1,
                                  onPressed: () {
                                    setState(() {
                                      star1 = Color(0xff00A8E5);
                                      star2 = Colors.grey;
                                      star3 = Colors.grey;
                                      star4 = Colors.grey;
                                      star5 = Colors.grey;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(0.0),
                                width: 30.0, // you can adjust the width as you need
                                child: IconButton(
                                  icon: new Icon(Icons.star,),
                                  color: star2,
                                  onPressed: () {
                                    setState(() {
                                      star1 = Color(0xff00A8E5);
                                      star2 = Color(0xff00A8E5);
                                      star3 = Colors.grey;
                                      star4 = Colors.grey;
                                      star5 = Colors.grey;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(0.0),
                                width: 30.0, // you can adjust the width as you need
                                child: IconButton(
                                  icon: new Icon(Icons.star,),
                                  color: star3,
                                  onPressed: () {
                                    setState(() {
                                      star1 = Color(0xff00A8E5);
                                      star2 = Color(0xff00A8E5);
                                      star3 = Color(0xff00A8E5);
                                      star4 = Colors.grey;
                                      star5 = Colors.grey;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(0.0),
                                width: 30.0, // you can adjust the width as you need
                                child: IconButton(
                                  icon: new Icon(Icons.star,),
                                  color: star4,
                                  onPressed: () {
                                    setState(() {
                                      star1 = Color(0xff00A8E5);
                                      star2 = Color(0xff00A8E5);
                                      star3 = Color(0xff00A8E5);
                                      star4 = Color(0xff00A8E5);
                                      star5 = Colors.grey;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(0.0),
                                width: 30.0, // you can adjust the width as you need
                                child: IconButton(
                                  icon: new Icon(Icons.star,),
                                  color: star5,
                                  onPressed: () {
                                    setState(() {
                                      star1 = Color(0xff00A8E5);
                                      star2 = Color(0xff00A8E5);
                                      star3 = Color(0xff00A8E5);
                                      star4 = Color(0xff00A8E5);
                                      star5 = Color(0xff00A8E5);
                                    });
                                  },
                                ),
                              ),
                            ]
                          ),
                          /*
                          Text(
                            "\nAdd comments/suggestions",
                              style: TextStyle(
                              fontSize:10,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlueAccent,
                              fontFamily: "Quicksand"
                          )
                          )
                          )*/
                          /*,
                          SizedBox(height: uniHeight(context)*.2),
                          RaisedButton(
                              padding: EdgeInsets.all((uniHeight(context)*uniWidth(context))*.009),
                              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50.0)),
                              textColor: Colors.white,
                              color: Color(0xff00A8E5),
                              child: Text('PAY NOW',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color:Colors.white,
                                  fontSize: uniHeight(context)*0.25,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Home()),
                                );
                              }
                          )
                           */
                        ]
                        )
                      )
                    ]
                )
            ),
      //floatingActionButton: RideButton(),
      ])
    )
    );
  }
}