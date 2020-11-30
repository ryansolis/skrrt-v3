import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'package:skrrt_app/appbar-ridebutton/ride_button.dart';
import 'package:skrrt_app/appbar-ridebutton/skrrt-appbar.dart';
import 'package:skrrt_app/home_page.dart';
import 'sidebar_page.dart';

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
                height: double.maxFinite,
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
                                "₱30.00",
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
                                "₱150.00",
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
                                Navigator.pop(context);
                                /*
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Home()),
                                );*/
                              }
                          ),
                          SizedBox(height: uniHeight(context)*.2),
                          Text(
                            "Rate Phoenix",
                              style: TextStyle(
                              fontSize:uniHeight(context)*.45,//15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Quicksand"
                          )
                          ),
                          Image(
                              image: AssetImage('assets/scooter_phoenix.png'),
                              height: uniHeight(context)*1.5,//100,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              Icon(Icons.star, color: Colors.grey, size: uniHeight(context)*.32),
                              Icon(Icons.star, color: Colors.grey, size: uniHeight(context)*.32),
                              Icon(Icons.star, color: Colors.grey, size: uniHeight(context)*.32),
                              Icon(Icons.star, color: Colors.grey, size: uniHeight(context)*.32),
                              Icon(Icons.star, color: Colors.grey, size: uniHeight(context)*.32),
                            ]
                          ),
                          Text(
                            "\nAdd comments/suggestions",
                              style: TextStyle(
                              fontSize:10,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlueAccent,
                              fontFamily: "Quicksand"
                          )
                          )
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

                  ],
                )
            ),
          ],
        ),
      ),
      //floatingActionButton: RideButton(),

    );
  }
}