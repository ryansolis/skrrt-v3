import 'package:skrrt_app/home_page.dart';
import 'package:flutter/material.dart';
//unused imports
// import 'dart:async';
// import 'package:skrrt_app/admin_page.dart';
// import 'login-module.dart';

class SuccessfulRide extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SuccessfulRidePage();
  }
}
class SuccessfulRidePage extends State<SuccessfulRide>{
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
                      height: headerSize(context) * 2.25,
                      width:headerSize(context) * 3,
                    ),
                    Text(
                        "SUCCESS!",
                        style: TextStyle(
                            fontSize:headerSize(context),//22,
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
                              fontSize:textSize(context),//22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: "Quicksand"
                          )
                      ),
                    ),
                    SizedBox(height: textSize(context)),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.15, vertical: MediaQuery.of(context).size.height * 0.020),
                          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50.0)),
                          onPrimary: Colors.white,
                          primary: Colors.white,),
                        child: Text('BACK TO HOME',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color:Color(0xff00A8E5),
                            fontSize: textSize(context),
                          ),
                        ),
                        onPressed: () {
                          Navigator.popUntil(context, ModalRoute.withName('tohome'));
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
                        }
                    ),
                  ]
              ),
            )
        )
    );
  }
}