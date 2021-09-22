import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:skrrt_app/appbar-ridebutton/ride_button.dart';
import 'package:skrrt_app/appbar-ridebutton/skrrt-appbar.dart';
import 'sidebar_page.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
//unused imports
// import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';
// import 'dart:ffi';

class PastRides extends StatefulWidget {
  @override
  _PastRidesState createState() => _PastRidesState();
}

class _PastRidesState extends State<PastRides> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var token;
  FlutterSession session = new FlutterSession();


  Future<List> getRides() async{
    token = await session.get("token");
    print(token);
    var url = "http://192.168.1.12/skrrt/getRides.php";
    var data = {
      "userID": token.toString(),
    };

    var res = await http.post(url,body: data);
    print(res.body);
    return await jsonDecode(res.body);
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

      body:
      Builder(
          builder: (BuildContext context){
            return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  Expanded(
                      child:FutureBuilder<List>(
                          future: getRides(),
                          // ignore: missing_return
                          builder: (context,ss) {
                            if (ss.hasError) {
                              print("ERROR");
                            }
                            else if (ss.hasData) {
                              return Rides(list: ss.data);
                            }
                            else {
                              return CircularProgressIndicator();
                            }
                          }
                      )
                  ),
                ]
            );
          }
      ),
//
//      SingleChildScrollView(
//        child: Column(
//          children: <Widget>[
//
//
//          ],
//        ),
//      ),
      floatingActionButton: RideButton(),
    );
  }
}

class Rides extends StatelessWidget {
  List list;
  var _color = 0xFFE7E7E7;
  var _color2 = 0xFF7D7D7D;
  Rides({this.list});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null?0:list.length,
        itemBuilder: (ctx,i){
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
                                list[i]["model"],
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                list[i]["rideDate"],
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
                              padding: EdgeInsets.all(3),
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
                                      list[i]["distance"] + " km",
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
                              padding: EdgeInsets.all(3),
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
                                      list[i]["min"] + ":" + list[i]["sec"],
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
                              padding: EdgeInsets.all(3),
                              height: 50,
                              //width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "₱" + list[i]["rideFare"].toString(),
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
    );
  }
}