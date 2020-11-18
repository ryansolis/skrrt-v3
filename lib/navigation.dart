import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  static final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(10.295666, 123.880472),
    zoom: 18.5,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 2,
                  child: GoogleMap(
                    initialCameraPosition: _cameraPosition,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('2km',
                                style: TextStyle(
                                  color: Color(0xFF0E0E0E),
                                  fontFamily: 'Quicksand',
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('travelled',
                                style: TextStyle(
                                  color: Color(0xFF7D7D7D),
                                  fontFamily: 'Quicksand',
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('5:45',
                                style: TextStyle(
                                  color: Color(0xFF0E0E0E),
                                  fontFamily: 'Quicksand',
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('total time',
                                style: TextStyle(
                                  color: Color(0xFF7D7D7D),
                                  fontFamily: 'Quicksand',
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 60.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            RaisedButton(
                                padding: EdgeInsets.all(12.0),
                                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50.0)),
                                textColor: Colors.white,
                                color: Color(0xff00A8E5),
                                child: Text('DONE',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color:Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                onPressed: () {
                                  /*Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Navigation()),
                                );*/
                                }
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 2, child: SizedBox(),),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Card(
                      color: Color(0xFFFFFFFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 70.0,
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.warning_amber_rounded,
                              color: Color(0xFFDC0505),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('You can\'t turn left.',
                                  style: TextStyle(
                                    color: Color(0xFFDC0505),
                                    fontFamily: 'Quicksand',
                                    fontSize: 14.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text('Try another way.',
                                  style: TextStyle(
                                    color: Color(0xFFDC0505),
                                    fontFamily: 'Quicksand',
                                    fontSize: 14.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Icon(Icons.headset,
                              color: Color(0xFF0E0E0E),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(flex: 1, child: SizedBox(),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
