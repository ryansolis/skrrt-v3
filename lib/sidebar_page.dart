import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:skrrt_app/admin_page.dart';
import 'account_module.dart';
import 'past_rides_page.dart';
import 'skrrt_wallet_page.dart';
import 'login_module.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// unused imports
//import 'home_page.dart';
// import 'dart:async';

class SideBar extends StatefulWidget {

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {

  var first_name = "",last_name= "", ridesTaken="",isAdmin="";
  var token;
  List ridesT;
  FlutterSession session = new FlutterSession();

  void getRidesTaken() async{
    token = await session.get("token");
    var url = "http://192.168.1.12/skrrt/ridesTaken-Name.php";
    var data = {
      "userid": token.toString(),
    };
    print(data);
    var res = await http.post(url,body: data);
    print(res.body);
    ridesT = await jsonDecode(res.body);
    print(ridesT.toString());
    first_name = ridesT[0]['fName'];
    last_name = ridesT[0]['lName'];
    ridesTaken = ridesT[0]['rideCount'];
    isAdmin = ridesT[0]['isAdmin'];
    setState(() {});
  }

  @override
  void initState() {
    
    super.initState();
    getRidesTaken();
  }

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height;

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
            children: <Widget>[
              Container(
                height: availableHeight,
                color: Color(0xFF00A8E5),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                      child: ListTile(
                        leading: Icon(Icons.arrow_back_ios, color: Colors.black, size: 18,),
                        onTap: (){
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Row(
                            children: <Widget>[
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage('assets/jess-brobrero.png'),
                                      fit: BoxFit.fill
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Column(
                                  children: <Widget>[
                                    Text(first_name + " " + last_name ,style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "Quicksand"
                                    ),),
                                    Text( ridesTaken.toString() + " rides taken", style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontFamily: "Quicksand"
                                    ),),
                                  ],
                                ),
                              ),
                            ]
                        ),
                      ),
                    ),
                    ListTile(
                      leading: SizedBox(
                        height: 25.0,
                        width: 30.0, // fixed width and height
                        child: Image.asset('assets/ic_wallet.png'),
                      ),
                      title: Text(
                        'SKRRT Wallet',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: "Quicksand"
                        ),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return SkrrtWallet();
                        }));
                      },
                    ),
                    ListTile(
                      leading: SizedBox(
                        height: 30.0,
                        width: 30.0, // fixed width and height
                        child: Image.asset('assets/ic_scooter.png'),
                      ),
                      title: Text(
                        'Past Rides',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: "Quicksand"
                        ),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return PastRides();
                        }));
                      },
                    ),
                    ListTile(
                      leading: SizedBox(
                        height: 35.0,
                        width: 30.0, // fixed width and height
                        child: Image.asset('assets/ic_person.png'),
                      ),
                      title: Text(
                        'Account',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: "Quicksand",
                        ),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return AccountView();
                        }));
                      },
                    ),
                    if(isAdmin=="1")
                    ListTile(
                        leading: SizedBox(
                          height: 35.0,
                          width: 30.0, // fixed width and height
                          child: Icon(Icons.addchart_outlined, color: Colors.white),
                        ),
                        title: Text(
                          'Admin',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: "Quicksand",
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) {
                            return AdminView();
                          }));
                        }
                    ),
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: ListTile(
                            leading: SizedBox(
                              height: 30.0,
                              width: 30.0, // fixed width and height
                              child: Image.asset('assets/ic_signout.png'),
                            ),
                            title: Text('Sign out',style: TextStyle(fontSize: 18,color: Colors.white,fontFamily: "Quicksand"),),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return LoginView();
                              }));
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]
        ),
      ),
    );
  }
}