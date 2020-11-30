import 'package:flutter/material.dart';
import 'package:skrrt_app/appbar-ridebutton/ride_button.dart';
import 'sidebar_page.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Account extends StatefulWidget {

  @override
  _AccountState createState() => _AccountState();
}



class _AccountState extends State<Account> {

  var session = FlutterSession();
  List userData;
  String _fullName="",fname="",lname="",_username="",pass="",_phoneNum="",_idNo="",_bdate="",_course,_year="";

  void getUserData() async{

    var token = await session.get("token");
    print(token);
    var url = "http://192.168.1.11/skrrt/getStudentData.php";
    var data = {
      "userID": token.toString(),
    };

    var res = await http.post(url,body: data);

    userData = await jsonDecode(res.body);
    fname = userData[0]['fname'];
    lname = userData[0]['lname'];
    _username = userData[0]['username'];
    pass = userData[0]['pass'];
    _phoneNum = userData[0]['phone'];
    _idNo= userData[0]['idNo'];
    _bdate= userData[0]['bdate'];
    _course = userData[0]['course'];
    _year = userData[0]['year'];
    _fullName = fname + " " +  lname;
    print(_fullName);

    await session.set("token",token);
    setState(() {});
  }

  String getLengthPass(){
    int l = pass.length;
    String _hidePass = "";
    for(int i = 0; i < l ;i++){
      _hidePass += "●";
    }
    return _hidePass;
  }

  Widget _buildUsername(){
    return TextFormField(
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white,),
          ),
          hintText: _username,
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
        //labelText: pass,
        hintText: getLengthPass(),
        hintStyle: TextStyle(
          fontFamily: 'Quicksand',
          fontSize: 16.0,
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    //getUserData();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white10,
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
                          "$_fullName",
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
                          '$_fullName',
                          style: TextStyle(
                            color: Color(0xFF7D7D7D),
                            fontFamily: 'Quicksand',
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          '$_phoneNum',
                          style: TextStyle(
                            color: Color(0xFF7D7D7D),
                            fontFamily: 'Quicksand',
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          '$_bdate',
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
                          '$_idNo',
                          style: TextStyle(
                            color: Color(0xFF7D7D7D),
                            fontFamily: 'Quicksand',
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          '$_course' + ' - ' + '$_year',
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