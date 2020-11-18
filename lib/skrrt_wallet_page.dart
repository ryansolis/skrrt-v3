import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'sidebar_page.dart';

class SkrrtWallet extends StatefulWidget {
  @override
  _SkrrtWalletState createState() => _SkrrtWalletState();
}

class _SkrrtWalletState extends State<SkrrtWallet> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var _month = ['Jan','Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec' ];
  var _currentMonthSelected = 'Jan';
  @override
  Widget build(BuildContext context) {
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
                            '₱1500.00',
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
                                  'Rides in ',
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
                              children: <Widget>[
                                Text(
                                  '₱143.00',
                                  style: TextStyle(
                                    //color: Color(0xFF05C853),
                                      fontFamily: "Montserrat",
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal
                                  ),
                                ),
                                Text(
                                    '+42.00',
                                    style: TextStyle(
                                        color: Color(0xFF05C853),
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

    );
  }
}