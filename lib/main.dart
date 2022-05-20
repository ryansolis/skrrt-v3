import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'launch_page.dart';
import 'new_user.dart';
import 'dart:io';
//unused imports
// import 'package:skrrt_app/payment_page.dart';
// import 'package:skrrt_app/successful_ride_page.dart';
// import 'home_page.dart';

// old main
// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: "Skrrt",
//     home: LaunchPage(),
//     routes:{
//       'tohome':(context) => NewUser(),
//     }
//   ));
// }

//new main
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'db2',
    options: Platform.isIOS
        ? const FirebaseOptions(
            googleAppID: '1:297855924061:ios:c6de2b69b03a5be8',
            gcmSenderID: '297855924061',
            databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
          )
        : const FirebaseOptions(
            googleAppID: '1:672349376975:android:cd0b852cb36684375502ba',
            apiKey: 'AIzaSyBolokaYNDFK0sDxS8FhwahVOpDDyVhTL4',
            databaseURL:
                'https://skrrt-d86f9-default-rtdb.asia-southeast1.firebasedatabase.app',
          ),
  );
  runApp(OverlaySupport(
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Skrrt",
        home: LaunchPage(),
        routes: {
          'tohome': (context) => NewUser(),
        }),
  ));
}


