import 'dart:ui';

import 'package:flutter/material.dart';
import 'navigation.dart';

class RentScooter extends StatelessWidget {
  double uniHeight(BuildContext context){
    if(MediaQuery.of(context).size.width<=600)
      return MediaQuery.of(context).size.height*0.1;
    else
      return MediaQuery.of(context).size.height*0.45;
  }
  double uniWidth(BuildContext context){
    if(MediaQuery.of(context).size.width<=600)
      return MediaQuery.of(context).size.width*0.1;
    else
      return MediaQuery.of(context).size.width*0.45;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, top: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Phoenix',
                          style: TextStyle(
                            color: Color(0xFF0E0E0E),
                            fontFamily: 'Quicksand',
                            fontSize: uniHeight(context)*.5,//30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: uniWidth(context)*1.2),
                        Text('1 available',
                          style: TextStyle(
                            color: Color(0xFFA62415),
                            fontFamily: 'Quicksand',
                            fontSize: uniHeight(context)*.35,//15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Text('Rent Scooter',
                      style: TextStyle(
                        color: Color(0xFF7D7D7D),
                        fontFamily: 'Quicksand',
                        fontSize: uniHeight(context)*.4,//25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: uniHeight(context)*.1),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Card(
                          color: Color(0xFF48CEFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                                      child: Text('Details',
                                        style: TextStyle(
                                          color: Color(0xFF0E0E0E),
                                          fontFamily: 'Quicksand',
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text('can carry heavy loads',
                                      style: TextStyle(
                                        color: Color(0xFF0E0E0E),
                                        fontFamily: 'Quicksand',
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text('(max: 45kg)',
                                      style: TextStyle(
                                        color: Color(0xFF0E0E0E),
                                        fontFamily: 'Quicksand',
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 25.0),
                                      child: Row(
                                        children: [
                                          Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Column(
                                                children: [
                                                  Text('650',
                                                    style: TextStyle(
                                                      color: Color(0xFF0E0E0E),
                                                      fontFamily: 'Quicksand',
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text('watt',
                                                    style: TextStyle(
                                                      color: Color(0xFF7D7D7D),
                                                      fontFamily: 'Quicksand',
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15.0),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Column(
                                                  children: [
                                                    Text('380',
                                                      style: TextStyle(
                                                        color: Color(0xFF0E0E0E),
                                                        fontFamily: 'Quicksand',
                                                        fontSize: 15.0,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text('mah',
                                                      style: TextStyle(
                                                        color: Color(0xFF7D7D7D),
                                                        fontFamily: 'Quicksand',
                                                        fontSize: 15.0,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Column(
                                                children: [
                                                  Text('30',
                                                    style: TextStyle(
                                                      color: Color(0xFF0E0E0E),
                                                      fontFamily: 'Quicksand',
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text('km/h',
                                                    style: TextStyle(
                                                      color: Color(0xFF7D7D7D),
                                                      fontFamily: 'Quicksand',
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        height: 225.0,
                        left: -50.0,
                        top: 25.0,
                        child: Image(image: AssetImage('assets/scooter_phoenix.png'))
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                    child: Card(
                      color: Color(0xFFE7E7E7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text('Location',
                                style: TextStyle(
                                  color: Color(0xFF0E0E0E),
                                  fontFamily: 'Quicksand',
                                  fontSize: uniHeight(context)*.35,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text('QXCSS',
                                      style: TextStyle(
                                        color: Color(0xFF0E0E0E),
                                        fontFamily: 'Quicksand',
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text('code',
                                      style: TextStyle(
                                        color: Color(0xFF7D7D7D),
                                        fontFamily: 'Quicksand',
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('ST Bldg.',
                                      style: TextStyle(
                                        color: Color(0xFF0E0E0E),
                                        fontFamily: 'Quicksand',
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text('station',
                                      style: TextStyle(
                                        color: Color(0xFF7D7D7D),
                                        fontFamily: 'Quicksand',
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('P10 / 3 mins',
                          style: TextStyle(
                            color: Color(0xFF0E0E0E),
                            fontFamily: 'Quicksand',
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Note: Every extra 5 mins will add P5.00 to your account.',
                          style: TextStyle(
                            color: Color(0xFFFB4D4D),
                            fontFamily: 'Quicksand',
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Center(
                      child: RaisedButton(
                          padding: EdgeInsets.symmetric(horizontal: 64.0, vertical: 14.0),
                          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50.0)),
                          textColor: Colors.white,
                          color: Color(0xff00A8E5),
                          child: Text('SCAN NOW',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color:Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Navigation()),
                            );
                          }
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
