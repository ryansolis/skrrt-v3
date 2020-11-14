import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'sidebar_page.dart';

class Account extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      drawer: SafeArea(
        child: SideBar(),
      ),
      body: Center(
        child: Container(
          child: Text(
            "Account",
            style: TextStyle(fontWeight: FontWeight.w900,fontSize: 28),),
        ),
      ),

    );
  }
}