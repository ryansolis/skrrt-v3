import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:skrrt_app/admin_page.dart';
import 'package:skrrt_app/payment_page.dart';
import 'package:skrrt_app/sign_in.dart';
import 'package:skrrt_app/sign_up.dart';
import 'package:skrrt_app/trial.dart';
import 'home_page.dart';
import 'launch_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Skrrt",
    home: SignIn(),
    routes:{
      'home':(context) => Home(),
    }
  ));
}

