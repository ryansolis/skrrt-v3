import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:skrrt_app/payment_page.dart';
import 'package:skrrt_app/navigation_alert/navigation_popup.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  Set<Marker> _markers ={};
  bool _hasPressedDone = false, _hasParked = false;
  GoogleMapController _controller;
  Location _location = Location();
  double distance = -1, distanceTravelled = 0;
  String endLocation;
  String timeElapsed = "0:00";
  Stopwatch _stopwatch = Stopwatch();
  final dur = const Duration(seconds: 1);
  LocationData _currentLocation;
  var rideID;

  var session = FlutterSession();

  void rideDuration() async {
    await session.set("time", _stopwatch.elapsed.inMinutes);
  }
  void save() async {
    rideID = await session.get("rideID");
    var url = "http://192.168.1.5/skrrt/rideFinish.php";
    var data = { // save duration in secs, distance & destination
      "rideID": rideID.toString(),
      "endLocation": endLocation.toString(),
      "distance": distanceTravelled.toString(),
      "rideDuration": _stopwatch.elapsed.inSeconds.toString()
    };
    print(data);
    var res = await http.post(url,body: data);
    if(jsonDecode(res.body) == "Success"){
      print("Success");
    }
    else{
      print("Failed");
    }
  }

  static final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(10.295666, 123.880472),
    zoom: 18.5,
  );

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
      _markers.add(
          Marker(
            markerId: MarkerId('id-5'),
            position: LatLng(10.283813,123.8590903),
            infoWindow: InfoWindow(
              title: 'Test Destination',
            ),
          )
      );
    });
    _controller = controller;
    _location.onLocationChanged.listen((l) {
      print(l.latitude.toString()+","+l.longitude.toString());
      if (_currentLocation!=null){
        setState(() {
          getDistance(_currentLocation, l);
        });
      }
      else{
        _currentLocation = l;
      }

      /*_controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 18.5,),
        ),
      );*/

      /*_markers.removeWhere((element) => element.markerId.value == 'current-loc');
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
      });*/
    });
  }
  void getDistance (LocationData prev, LocationData current) async{
    double d = await Geolocator().distanceBetween(
      prev.latitude,
      prev.longitude,
      current.latitude,
      current.longitude,
    );
    if (d>=5){
      distanceTravelled += d;
      _currentLocation = current;
    }
  }

  Future<bool> checkParkingDistance() async {
    bool isNearParkingPoint = false;
    for (int i=0; i<_markers.length; i++){
      LatLng p = _markers.elementAt(i).position;
      // Calculating the distance between the start and end positions
      // with a straight path, without considering any route
      double distanceInMeters = await Geolocator().distanceBetween(
        _currentLocation.latitude,
        _currentLocation.longitude,
        p.latitude,
        p.longitude,
      );
      if (distanceInMeters<=20){
        distance = distanceInMeters;
        endLocation = _markers.elementAt(i).infoWindow.title;
        isNearParkingPoint = true;
        break;
      }
    }
    return isNearParkingPoint;
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
    print("time");
    print(_stopwatch.elapsed.inSeconds);
    _stopwatch.stop();
    print("time");
    print(_stopwatch.elapsed.inSeconds);
  }

  @override
  void initState() {
    super.initState();
    startTimeElapsed();
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
                              Text(distanceTravelled.toString()+"m",
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
                                    checkParkingDistance().then((value) {
                                      if (value){
                                        _hasParked = true;
                                        rideDuration();
                                        stopTimeElapsed();
                                        save();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => PaymentPage()),
                                        );
                                      }
                                    });
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
            Visibility(
              visible: (_hasPressedDone && !_hasParked)? true: false,
              child: NavPopup(),
            ),
          ],
        ),
      ),
    );
  }
}
