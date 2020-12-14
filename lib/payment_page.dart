import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
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

double textSize(BuildContext context){
  if(MediaQuery.of(context).size.width<=600)
    return MediaQuery.of(context).size.height*0.025;
  else
    return MediaQuery.of(context).size.height*0.030;
}
double headerSize(BuildContext context){
  if(MediaQuery.of(context).size.width<=600){
    print("hello");
    return MediaQuery.of(context).size.width*0.10;
  }
  else{
    print("hi");
    return MediaQuery.of(context).size.width*0.09;
  }
}

double subHeader(BuildContext context){
  if(MediaQuery.of(context).size.width<=600){
    print("hello");
    return MediaQuery.of(context).size.width*0.06;
  }
  else{
    print("hi");
    return MediaQuery.of(context).size.width*0.05;
  }
}

class _PaymentPageState extends State<PaymentPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Color star1;
  Color star2;
  Color star3;
  Color star4;
  Color star5;
  String _balance = "₱";
  int stars = 0,bal=0,amo=0;

  var session = FlutterSession();
  void viewBalance() async {
    //print("hello");
    var token = await session.get("token");
    var time = await session.get("time");

    print("here!!!");
    var url = "http://192.168.1.4/skrrt/balance.php";
    var data = {
      "userID": token.toString(),
    };
    //print(data);

    var res = await http.post(url,body:data);
    //print(jsonDecode(res.body));

    List userData = await jsonDecode(res.body);
    print(userData);
    bal=int.parse(userData[0]["balance"]);
    _balance += userData[0]["balance"].toString() + ".00";
    var _amount = time * 2 + 2;

    amount += _amount.toString();
    amount += ".00";
    amo = int.parse(_amount.toString());
    print("bal = "+bal.toString()+";amo= "+amo.toString());
    //print("Amount = "+'$_amount');
    //print("YES3");
    /*if(jsonDecode(res.body) == "okay"){
      print("YESSSSSSS");
    }
    else{
      print("NOOOOOO");
    }*/
    setState(() {});
  }
  String amount ="₱";

  void payRide() async {
    //print("hello");

     var time = await session.get("time");
     var _userID = await session.get("token");
     var _scooterID = await session.get("scooterID");
     var _rideID = await session.get("rideID");

    var _amount = time * 2 + 2;
    print("halo");
    var url = "http://192.168.1.4/skrrt/pay.php";  //localhost, change 192.168.1.9 to ur own localhost
    var data = {
      "rideID" : _rideID.toString(),
      "time":time.toString(),
      "amount": _amount.toString(),
      "userID": _userID.toString(),
      "stars": stars.toString(),
      "scooterID": _scooterID.toString()
    };
    print("Data: "+'$data');
    var res = await http.post(url,body:data);
    print(res.body);
    //print("YES3");
    // if(jsonDecode(res.body) == "okay"){
    //   print("YESSSSSSS");
    // }
    // else{
    //   print("2NOOOOOO");
    // }
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
                padding: EdgeInsets.all(textSize(context)),
                width: double.infinity,
                //color: Colors.lightBlue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.fromLTRB(0,10,0,0),
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.35,
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
                                    fontSize:textSize(context),//13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "Quicksand"
                                )
                            ),
                            Text(
                                "\nAmount due:",
                                style: TextStyle(
                                    fontSize:textSize(context),//10,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Quicksand"
                                )
                            ),
                            Text(
                                amount,
                                style: TextStyle(
                                    fontSize:subHeader(context),//22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: "Quicksand"
                                )
                            ),
                            Text(
                                "\nAvailable Skrrt Load Balance",
                                style: TextStyle(
                                    fontSize:textSize(context),//10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: "Quicksand"
                                )
                            ),
                            Text(
                                _balance,
                                style: TextStyle(
                                    fontSize:subHeader(context),//22,
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
                                      fontSize: textSize(context),
                                    ),
                                  ),
                                  onPressed: () {
                                    if(bal>=amo) {
                                        payRide();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SuccessfulRide()),
                                        );
                                      }
                                    else{
                                      Fluttertoast.showToast(msg: "Insufficient funds, please load your wallet before paying.",toastLength: Toast.LENGTH_SHORT);
                                    }
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
                          SizedBox(height: headerSize(context)),
                          Text(
                            "Rate Our Services",
                              style: TextStyle(
                              fontSize:subHeader(context),//15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Quicksand"
                          )
                          ),
                          SizedBox(height: subHeader(context)),
                          Image(
                              image: AssetImage('assets/skrrt_logowhite.png'),
                              height: headerSize(context) * 2,//100,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:[
                              Container(
                                width: 30.0, // you can adjust the width as you need
                                child: IconButton(
                                  iconSize: subHeader(context),
                                  padding: EdgeInsets.all(0),
                                  icon: new Icon(Icons.star,),
                                  color: star1,
                                  onPressed: () {
                                    setState(() {
                                      star1 = Color(0xff00A8E5);
                                      star2 = Colors.grey;
                                      star3 = Colors.grey;
                                      star4 = Colors.grey;
                                      star5 = Colors.grey;
                                      stars = 1;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                width: 30.0, // you can adjust the width as you need
                                child: IconButton(
                                  iconSize: subHeader(context),
                                  padding: EdgeInsets.all(0),
                                  icon: new Icon(Icons.star,),
                                  color: star2,
                                  onPressed: () {
                                    setState(() {
                                      star1 = Color(0xff00A8E5);
                                      star2 = Color(0xff00A8E5);
                                      star3 = Colors.grey;
                                      star4 = Colors.grey;
                                      star5 = Colors.grey;
                                      stars = 2;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                width: 30.0, // you can adjust the width as you need
                                child: IconButton(
                                  iconSize: subHeader(context),
                                  padding: EdgeInsets.all(0),
                                  icon: new Icon(Icons.star,),
                                  color: star3,
                                  onPressed: () {
                                    setState(() {
                                      star1 = Color(0xff00A8E5);
                                      star2 = Color(0xff00A8E5);
                                      star3 = Color(0xff00A8E5);
                                      star4 = Colors.grey;
                                      star5 = Colors.grey;
                                      stars = 3;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                width: 30.0, // you can adjust the width as you need
                                child: IconButton(
                                  iconSize: subHeader(context),
                                  padding: EdgeInsets.all(0),
                                  icon: new Icon(Icons.star,),
                                  color: star4,
                                  onPressed: () {
                                    setState(() {
                                      star1 = Color(0xff00A8E5);
                                      star2 = Color(0xff00A8E5);
                                      star3 = Color(0xff00A8E5);
                                      star4 = Color(0xff00A8E5);
                                      star5 = Colors.grey;
                                      stars = 4;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                width: 30.0, // you can adjust the width as you need
                                child: IconButton(
                                  iconSize: subHeader(context),
                                  padding: EdgeInsets.all(0),
                                  icon: new Icon(Icons.star,),
                                  color: star5,
                                  onPressed: () {
                                    setState(() {
                                      star1 = Color(0xff00A8E5);
                                      star2 = Color(0xff00A8E5);
                                      star3 = Color(0xff00A8E5);
                                      star4 = Color(0xff00A8E5);
                                      star5 = Color(0xff00A8E5);
                                      stars = 5;
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