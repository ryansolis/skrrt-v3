import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:skrrt_app/admin_page.dart';
import 'package:skrrt_app/payment_page.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  Set<Marker> _markers ={};
  bool _visible = false;
  bool _visible1 = false;
  bool _hasPressedDone = false;
  GoogleMapController _controller;
  Location _location = Location();
  String timeElapsed = "0:00";
  Stopwatch _stopwatch = Stopwatch();
  final dur = const Duration(seconds: 1);

  static final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(10.295666, 123.880472),
    zoom: 18.5,
  );

  void _onMapCreated(GoogleMapController controller){
    setState(() {
      _markers.add(
          Marker(
            markerId: MarkerId('id-1'),
            position: LatLng(10.295666, 123.880472),
            infoWindow: InfoWindow(
              title: 'CIT Parking Area',
            ),
          )
      );
      _markers.add(
          Marker(
              markerId: MarkerId('id-2'),
              position: LatLng(10.295235, 123.880835),
              infoWindow: InfoWindow(
                  title: 'CIT Main Library',
              ),
          )
      );
      _markers.add(
          Marker(
              markerId: MarkerId('id-3'),
              position: LatLng(10.296086, 123.880536),
              infoWindow: InfoWindow(
                  title: 'Main Canteen',
              ),
          )
      );
      _markers.add(
          Marker(
            markerId: MarkerId('id-4'),
            position: LatLng(10.295484, 123.880038),
            infoWindow: InfoWindow(
              title: 'CIT Engineering Bldg.',
            ),
          )
      );
    });
    _controller = controller;
    _location.onLocationChanged.listen((l) {
      /*_controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 18.5,),
        ),
      );*/
      _markers.removeWhere((element) => element.markerId.value == 'current-loc');
      setState(() {
        _markers.add(
            Marker(
              markerId: MarkerId('current-loc'),
              position: LatLng(l.latitude, l.longitude),
              infoWindow: InfoWindow(
                title: 'You',
              ),
            )
        );
      });
    });
    startTimeElapsed();
  }

  void startTimeElapsed(){
    _stopwatch.start();
    startTimer();
  }

  void startTimer(){
    Timer(dur, keepRunning);
  }

  void keepRunning(){
    if (_stopwatch.isRunning){
      startTimer();
    }
    setState(() {
      timeElapsed = (_stopwatch.elapsed.inMinutes%60).toString() + ":"
                  + (_stopwatch.elapsed.inSeconds%60).toString().padLeft(2, "0");
      if (_stopwatch.elapsed.inHours>=1){
        timeElapsed = _stopwatch.elapsed.inHours.toString() + ":" + timeElapsed;
      }
    });
  }

  void stopTimeElapsed(){
    _stopwatch.stop();
  }

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
                    onMapCreated: _onMapCreated,
                    markers: _markers,
                    myLocationEnabled: true,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              Text(timeElapsed,
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
                        padding: const EdgeInsets.symmetric(horizontal: 60.0),
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
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                onPressed: () {
                                  if (_hasPressedDone==false){
                                    _hasPressedDone=true;
                                  }
                                  else{
                                    stopTimeElapsed();
                                    /*Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => PaymentPage()),
                                    );*/
                                  }
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
                            Icon(Icons.volume_up_rounded,
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
