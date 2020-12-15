import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:skrrt_app/appbar-ridebutton/ride_button.dart';
import 'package:skrrt_app/appbar-ridebutton/skrrt-appbar.dart';
import 'sidebar_page.dart';

class SkrrtWallet extends StatefulWidget {
  @override
  _SkrrtWalletState createState() => _SkrrtWalletState();
}

class _SkrrtWalletState extends State<SkrrtWallet> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var session = FlutterSession();
  var _month = ['Jan','Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec' ];
  var _currentMonthSelected = 'Jan';
  var _wallet = '125';
  var _rideExpense = '0';
  var _prevExpense = '0';

  //DB functionality

  void getExpenses(int mo) async{
    var token = await session.get("token");
    //print(token);
    var url = "http://192.168.1.14/skrrt/getExpenses.php";
    var data = {
      "userID": token.toString(),
      "monthS":"2020-"+mo.toString()+"-01",
      "monthF":"2020-"+mo.toString()+"-31",
    };
    print(data);
    var res = await http.post(url,body:data);
    //print(jsonDecode(res.body));

    List exp = await jsonDecode(res.body);
    print(exp);
    _rideExpense = exp[0]["sum"];
    if(_rideExpense==null)
      _rideExpense="0";
    print(_rideExpense);

    data = {
      "userID": token.toString(),
      "monthS":"2020-"+(mo-1).toString()+"-01",
      "monthF":"2020-"+(mo-1).toString()+"-31",
    };
    print(data);
    res = await http.post(url,body:data);
    //print(jsonDecode(res.body));

    exp = await jsonDecode(res.body);
    print(exp);
    _prevExpense = exp[0]["sum"];
    if(_prevExpense==null)
      _prevExpense="0";
    _prevExpense=(int.parse(_prevExpense.toString())-int.parse(_rideExpense.toString())).toString();
    print(_prevExpense);
    await session.set("token",token);
    setState(() {});
  }

  void getUserData() async{

    var token = await session.get("token");
    //print(token);
    var url = "http://192.168.1.14/skrrt/getStudentData.php";
    var data = {
      "userID": token.toString(),
    };

    var res = await http.post(url,body: data);

    List userData = await jsonDecode(res.body);

    //print(userData.toString());
    _wallet = userData[0]["wallet"];
    await session.set("token",token);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    getUserData();
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
              width: double.infinity,
              height: 220,
              padding: EdgeInsets.all(15.0),
              child: Center(
                child: Image(
                  width: 200,
                  height: 220,
                  image: AssetImage('assets/skrrt-wallet-img.png'),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
              padding: EdgeInsets.all(10),
              width: double.infinity,
              height: 200,
              //color: Colors.lightBlue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Account Balance",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Quicksand"
                    )
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    width: double.infinity,
                    height: 125,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Color(0xFFE7E7E7),
                    ),
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Remaining Wallet Balance',
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(12,0,0,0),
                          child: Text(
                            '₱'+ _wallet+'.00',
                            style: TextStyle(
                              color: Color(0xFF05C853),
                              fontFamily: "Montserrat",
                              fontSize: 30,
                              fontWeight: FontWeight.normal
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ),
            Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: 200,
                //color: Colors.lightBlue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        "Expenses",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Quicksand"
                        )
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      width: double.infinity,
                      height: 125,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0xFFE7E7E7),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            //color: Colors.red,
                            height: 50,
                            padding: EdgeInsets.all(12),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Expenses in ',
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 13,
                                  ),
                                ),
                                DropdownButton<String>(
                                    underline: Container(
                                      height: 2,
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                    items: _month.map((String dropDownStringItem) {
                                      return DropdownMenuItem<String>(
                                        value: dropDownStringItem,
                                        child: Text(dropDownStringItem),
                                      );
                                    }).toList(),
                                    onChanged: (String newMonthSelected){
                                      getExpenses(_month.indexOf(newMonthSelected)+1);
                                      setState(() {
                                        this. _currentMonthSelected = newMonthSelected;
                                      });
                                    },
                                  value: _currentMonthSelected,
                                ),
                              ],
                            )
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[/*
                                if(_currentMonthSelected!='Nov'&&_currentMonthSelected!='Dec')
                                  Text(
                                    '0.00',
                                    style: TextStyle(
                                      //color: Color(0xFF05C853),
                                        fontFamily: "Montserrat",
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal
                                    ),
                                  ),
                                if(_currentMonthSelected=='Nov')
                                Text(
                                 '143.00',
                                  style: TextStyle(
                                    //color: Color(0xFF05C853),
                                      fontFamily: "Montserrat",
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal
                                  ),
                                ),
                                if(_currentMonthSelected=='Dec')*/
                                  Text(
                                    '₱'+'$_rideExpense'+'.00',
                                    style: TextStyle(
                                      //color: Color(0xFF05C853),
                                        fontFamily: "Montserrat",
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal
                                    ),
                                  ),
                                int.parse(_prevExpense)>=0 ?
                                Text(
                                  '₱'+'$_prevExpense'+'.00',
                                  style: TextStyle(
                                      color: Color(0xFF05C853),
                                      fontFamily: "Montserrat",
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal
                                  ),
                                ):
                                Text(
                                  '₱'+'$_prevExpense'+'.00',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: "Montserrat",
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal
                                  ),
                                ),
                              ]
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
            ),
          ],
        ),
      ),
      floatingActionButton: RideButton(),

    );
  }
}