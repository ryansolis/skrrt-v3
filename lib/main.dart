import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'launch_page.dart';
import 'new_user.dart';
//unused imports
// import 'package:skrrt_app/payment_page.dart';
// import 'package:skrrt_app/successful_ride_page.dart';
// import 'home_page.dart';
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Skrrt",
    home: LaunchPage(),
    routes:{
      'tohome':(context) => NewUser(),
    }
  ));
}

