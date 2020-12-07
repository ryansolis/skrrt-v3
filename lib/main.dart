import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'launch_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Skrrt",
    home: LaunchPage(),
    routes:{
      'home':(context) => Home(),
    }
  ));
}

