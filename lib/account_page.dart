import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'package:skrrt_app/appbar-ridebutton/ride_button.dart';
import 'sidebar_page.dart';

class Account extends StatelessWidget {

  Widget _buildUsername(){
    return TextFormField(
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white,),
          ),
          hintText: 'jessobrero',
          hintStyle: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 16.0,
            color: Colors.white,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 30,
            ),
          )
      ),
      keyboardType: TextInputType.text,

    );
  }
  Widget _buildPassword() {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white,),
        ),
        hintText: '***********',
        hintStyle: TextStyle(
          fontFamily: 'Quicksand',
          fontSize: 18.0,
          color: Colors.white,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(right: 15),
          child: Icon(
            Icons.lock_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
      keyboardType: TextInputType.text,
      obscureText: true,
    );
  }
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
      drawer: SideBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Account',
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            Container(
                width: double.infinity,
                height: 200,
                padding: EdgeInsets.all(15.0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Image(
                        width: 200,
                        height: 120,
                        image: AssetImage('assets/jess-brobrero.png'),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          'Jess Brobrero',
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ]
                  ),
                )
            ),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(15),
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Color(0xFF48CEFF),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Account Details',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20,0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _buildUsername(),
                        SizedBox(height:10),
                        _buildPassword(),
                        SizedBox(height:20),
                        RaisedButton(
                          child: Text(
                            "CHANGE",
                            style: TextStyle(
                              color: Color(0xFF00A8E5),
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0)),
                          color: Colors.white,
                          disabledColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(15),
              height: 210,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Color(0xFFE7E7E7),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Personal Details',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(25,25,0,0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[

                        Text(
                          'Jess Brobrero',
                          style: TextStyle(
                            color: Color(0xFF7D7D7D),
                            fontFamily: 'Quicksand',
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          '+69 363 396 7814',
                          style: TextStyle(
                            color: Color(0xFF7D7D7D),
                            fontFamily: 'Quicksand',
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          '07-09-1999',
                          style: TextStyle(
                            color: Color(0xFF7D7D7D),
                            fontFamily: 'Quicksand',
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(15),
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Color(0xFFE7E7E7),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Student Details',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(25,25,0,0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[

                        Text(
                          '12-25-25-966',
                          style: TextStyle(
                            color: Color(0xFF7D7D7D),
                            fontFamily: 'Quicksand',
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          'BSCS - 3',
                          style: TextStyle(
                            color: Color(0xFF7D7D7D),
                            fontFamily: 'Quicksand',
                            fontSize: 16,
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: RideButton(),

    );
  }
}