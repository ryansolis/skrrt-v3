import 'dart:async';
import 'package:skrrt_app/admin_page.dart';

import 'sign_in.dart';
import 'package:flutter/material.dart';

class SuccessfulRide extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SuccessfulRidePage();
  }
}
class SuccessfulRidePage extends State<SuccessfulRide>{
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage("assets/check.png"),
                      height: 140,
                      width:140,
                    ),
                    Text(
                        "SUCCESS!",
                        style: TextStyle(
                            fontSize:uniHeight(context)*.5,//22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: "Quicksand"
                        )
                    ),
                    Padding(
                      padding:EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.25, vertical: 20),
                      child: Text(
                          "You successfully arrived to your destination.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize:uniHeight(context)*.25,//22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: "Quicksand"
                          )
                      ),
                    ),
                    SizedBox(height: uniHeight(context)*.2),
                    RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.15, vertical: MediaQuery.of(context).size.height * 0.020),
                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50.0)),
                        textColor: Colors.white,
                        color: Colors.white,
                        child: Text('BACK TO HOME',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color:Color(0xff00A8E5),
                            fontSize: uniHeight(context)*0.25,
                          ),
                        ),
                        onPressed: () {
                          Navigator.popUntil(context, ModalRoute.withName('home'));
                        }
                    ),
                  ]
              ),
            )
        )
    );
  }
}