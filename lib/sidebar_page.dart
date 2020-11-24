import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skrrt_app/admin_page.dart';
import 'account_page.dart';
import 'past_rides_page.dart';
import 'skrrt_wallet_page.dart';

class SideBar extends StatelessWidget {



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
                                      Text("Jess Brobrero",style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "Quicksand"
                                      ),),
                                      Text("15 rides taken", style: TextStyle(
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
                            return Account();
                          }));
                        },
                      ),
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
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return AdminPage();
                          }));
                        },
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