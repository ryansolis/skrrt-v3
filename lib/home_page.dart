import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'sidebar_page.dart';
import 'rent_scooter.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

import 'payment_page.dart';

import 'main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var session = FlutterSession();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _visible = false;
  bool _visible1 = false;
  bool _visible2 = false;
  bool _visible3 = false;
  String _selected  = "";
  String _station = "";
  Color _color = Colors.white;
  Color _color1 = Colors.white;

  void _fetchModels() async{
    var url = "http://192.168.1.9/skrrt/home.php";
    var data = {
      "station": _station,
    };
    print(_station);
    var res = await http.post(url,body:data);
    print(jsonDecode(res.body));

    if(jsonDecode(res.body) == "no phoenix"){
      setState(() {
        _selected  = "";
        _color = Colors.white;
        _color1 = Colors.white;
        _visible = false;
        _visible1 = false;
        _visible2 = true;
        _visible3 = false;
      });
    }
    else if(jsonDecode(res.body) == "no yami"){
      setState(() {
        _selected  = "";
        _color = Colors.white;
        _color1 = Colors.white;
        _visible = false;
        _visible1 = true;
        _visible2 = false;
        _visible3 = false;
      });
    }
    else if(jsonDecode(res.body) == "has both"){
      setState(() {
        _selected  = "";
        _color = Colors.white;
        _color1 = Colors.white;
        _visible = false;
        _visible1 = false;
        _visible2 = false;
        _visible3 = true;
      });
    }
    else{
      setState(() {
        _selected  = "";
        _color = Colors.white;
        _color1 = Colors.white;
        _visible = true;
        _visible1 = false;
        _visible2 = false;
        _visible3 = false;
      });
    }
  }

  void rideScooter() async {
    //print("hello");
    var token = await session.get("token");
    print(token);

    var url = "http://192.168.1.9/skrrt/rides.php";  //localhost, change 192.168.1.9 to ur own localhost
    var data = {
      "start": _station,
      "userID": token.toString(),
      "model": _selected,
      "date": DateTime.now().toString()
    };

    var res = await http.post(url,body:data);
    print(jsonDecode(res.body));
    List userData = await jsonDecode(res.body);

    var scooterID = userData[0]["scooter"];
    var rideID = userData[1]["lastID"];
    print("userData = "+'$userData');
    print(rideID);

    await session.set("rideID",rideID);
    await session.set("scooter",scooterID);
    await session.set("token",token);
  }


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Set<Marker> _markers ={};
  BitmapDescriptor mapMarker;

  double uniHeight(BuildContext context){
    return MediaQuery.of(context).size.height*0.1;
  }
  double uniWidth(BuildContext context){
    return MediaQuery.of(context).size.width*0.1;
  }

  bool _tabletSized(BuildContext context){
    return MediaQuery.of(context).size.width > 700;
  }

  @override
  void initState(){
    super.initState();
    setCustomMarker();
    setState(() {});
  }

  void setCustomMarker() async{
    mapMarker = await getBitmapDescriptorFromAssetBytes("assets/skrrt_marker1.png", 150);
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }

  Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(String path, int width) async {
    final Uint8List imageData = await getBytesFromAsset(path, width);
    return BitmapDescriptor.fromBytes(imageData);
  }

  void _onMapCreated(GoogleMapController controller){
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('id-1'),
          position: LatLng(10.294520, 123.880951),
          icon: mapMarker,
          infoWindow: InfoWindow(
                title: 'CIT ST Building',
                //snippet: '2 Available'
            ),
            onTap: () {
              setState(() {
                _station = "ST Building";
                _fetchModels();
              });
            }
        )
      );
      _markers.add(
          Marker(
            markerId: MarkerId('id-2'),
            position: LatLng(10.295235, 123.880835),
            icon: mapMarker,
            infoWindow: InfoWindow(
              title: 'CIT Main Library',
              //snippet: '2 Available'
            ),
            onTap: () {
                setState(() {
                  _station = "Main Library";
                  _fetchModels();
                });
            }

          )
      );
      _markers.add(
          Marker(
            markerId: MarkerId('id-3'),
            position: LatLng(10.296086, 123.880536),
            icon: mapMarker,
              infoWindow: InfoWindow(
                  title: 'Main Canteen',
                  snippet: '1 Available'
              ),
              onTap: () {
                setState(() {
                  _station = "Main Canteen";
                  _fetchModels();
                });
              }
          )
      );
      _markers.add(
          Marker(
            markerId: MarkerId('id-4'),
            position: LatLng(10.295484, 123.880038),
            icon: mapMarker,
              infoWindow: InfoWindow(
                  title: 'CIT Gym',
                  //snippet: '2 Available'
              ),
              onTap: () {
                setState(() {
                  _station = "Gym";
                  _fetchModels();
                });
              }
          )
      );
    });
  }

  Widget _none(){
    return Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: _visible,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 7, child: SizedBox(),),
            Flexible(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: uniWidth(context)*1.2),//const EdgeInsets.symmetric(horizontal: 50.0),
                child: Card(
                  color: Color(0xFFFFFFFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(uniWidth(context)*.1),//const EdgeInsets.all(10.0),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left:10, top:10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Models in ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Quicksand',
                                    fontSize: uniHeight(context)*.25,//15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(_station,
                                  style: TextStyle(
                                    color: Color(0xff00A8E5),
                                    fontFamily: 'Quicksand',
                                    fontSize: uniHeight(context)*.25,//15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ]
                          ),
                        ),
                        Theme(
                            data: ThemeData(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                            child:
                            InkWell(
                              onTap: () {
                                setState((){
                                });
                              },
                              child: FlatButton(
                                  child: Table(
                                    //border: TableBorder.all(),
                                      columnWidths: {
                                        0: FlexColumnWidth(.15),
                                        1: FlexColumnWidth(.40),
                                      },
                                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                      children: [
                                        TableRow(
                                            children: [
                                              Container(height: uniHeight(context)*.3,),
                                              Container(height: uniHeight(context)*.3,),
                                            ]
                                        ),

                                        TableRow(
                                            children: [
                                              Icon(Icons.electric_scooter_rounded,
                                                color: Colors.black54,
                                                size: uniWidth(context)*.8,//,
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text('PHOENIX',
                                                        style: TextStyle(
                                                          color: Colors.black54,
                                                          fontFamily: 'Quicksand',
                                                          fontSize: uniHeight(context)*.24,//14.0,
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      Text(' (not available)',
                                                        style: TextStyle(
                                                          color: Colors.black54,
                                                          fontFamily: 'Quicksand',
                                                          fontSize: uniHeight(context)*.18,//14.0,
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                  Text('regular scooter',
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                      fontFamily: 'Quicksand',
                                                      fontSize: uniHeight(context)*.2,//12.0,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ]
                                        ),
                                      ]
                                  )
                              ),
                            )
                        ),
                        Theme(
                            data: ThemeData(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                            child:
                            InkWell(
                              onTap: () {
                                setState((){
                                });
                              },
                              child: FlatButton(
                                  child: Table(
                                    //border: TableBorder.all(),
                                      columnWidths: {
                                        0: FlexColumnWidth(.16),
                                        1: FlexColumnWidth(.40),
                                      },
                                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                      children: [
                                        TableRow(
                                            children: [
                                              Container(height: uniHeight(context)*.3,),
                                              Container(height: uniHeight(context)*.3,),
                                            ]
                                        ),
                                        TableRow(
                                            children: [
                                              Icon(Icons.electric_scooter_rounded,
                                                color: Colors.black54,
                                                size: uniWidth(context)*.8,//,
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                      children:[
                                                        Text('YAMI',
                                                          style: TextStyle(
                                                            color: Colors.black54,
                                                            fontFamily: 'Quicksand',
                                                            fontSize: uniHeight(context)*.24,//14.0,
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                        Text(' (not available)',
                                                          style: TextStyle(
                                                            color: Colors.black54,
                                                            fontFamily: 'Quicksand',
                                                            fontSize: uniHeight(context)*.18,//14.0,
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ]
                                                  ),
                                                  Text('carry heavy loads',
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                      fontFamily: 'Quicksand',
                                                      fontSize: uniHeight(context)*.2,//12.0,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ]
                                        ),
                                      ]
                                  )
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //Flexible( flex:1, child: Container(color:Colors.transparent)),
            Flexible(
              flex: 2,
              child: RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.26, vertical: MediaQuery.of(context).size.height * 0.020),
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50.0)),
                  textColor: Colors.white,
                  color: Color(0xff00A8E5),
                  child: Text('RIDE NOW',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color:Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    if(_selected != ""){
                      rideScooter();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RentScooter()),
                      );
                    }
                    else{
                      Fluttertoast.showToast(msg: "Please select model of scooter.",toastLength: Toast.LENGTH_SHORT);
                    }
                  }
              ),
            ),
          ],
        )
    );
  }

  Widget _phoenix(){
    return Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: _visible1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 7, child: SizedBox(),),
            Flexible(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: uniWidth(context)*1.2),//const EdgeInsets.symmetric(horizontal: 50.0),
                child: Card(
                  color: Color(0xFFFFFFFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(uniWidth(context)*.1),//const EdgeInsets.all(10.0),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left:10, top:10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Models in ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Quicksand',
                                    fontSize: uniHeight(context)*.25,//15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(_station,
                                  style: TextStyle(
                                    color: Color(0xff00A8E5),
                                    fontFamily: 'Quicksand',
                                    fontSize: uniHeight(context)*.25,//15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ]
                          ),
                        ),
                        Theme(
                            data: ThemeData(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                            child:
                            InkWell(
                              onTap: () {
                                setState((){
                                  _selected = "Phoenix";
                                  _color = Color(0xff00A8E5) ;
                                  _color1 = Colors.white ;
                                });
                              },
                              child: FlatButton(
                                  child: Table(
                                    //border: TableBorder.all(),
                                      columnWidths: {
                                        0: FlexColumnWidth(.15),
                                        1: FlexColumnWidth(.40),
                                        2: FlexColumnWidth(.1)
                                      },
                                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                      children: [
                                        TableRow(
                                            children: [
                                              Container(height: uniHeight(context)*.3,),
                                              Container(height: uniHeight(context)*.3,),
                                              Container(height: uniHeight(context)*.3,)
                                            ]
                                        ),
                                        TableRow(
                                            children: [
                                              Icon(Icons.electric_scooter_rounded,
                                                color: Color(0xff00A8E5),
                                                size: uniWidth(context)*.8,//,
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('PHOENIX',
                                                    style: TextStyle(
                                                      color: Color(0xff00A8E5),
                                                      fontFamily: 'Quicksand',
                                                      fontSize: uniHeight(context)*.24,//14.0,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text('regular scooter',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Quicksand',
                                                      fontSize: uniHeight(context)*.2,//12.0,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                              Icon(
                                                Icons.check_circle,
                                                color: _color,
                                              ),
                                            ]
                                        ),
                                      ]
                                  )
                              ),
                            )
                        ),

                        Theme(
                            data: ThemeData(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                            child:
                            InkWell(
                              onTap: () {
                                setState((){

                                });
                              },
                              child: FlatButton(
                                  child: Table(
                                    //border: TableBorder.all(),
                                      columnWidths: {
                                        0: FlexColumnWidth(.15),
                                        1: FlexColumnWidth(.40),
                                        2: FlexColumnWidth(.1)
                                      },
                                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                      children: [
                                        TableRow(
                                            children: [
                                              Container(height: uniHeight(context)*.3,),
                                              Container(height: uniHeight(context)*.3,),
                                              Container(height: uniHeight(context)*.3,)
                                            ]
                                        ),
                                        TableRow(
                                            children: [
                                              Icon(Icons.electric_scooter_rounded,
                                                color: Colors.black54,
                                                size: uniWidth(context)*.8,//,
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text('YAMI ',
                                                        style: TextStyle(
                                                          color: Colors.black54,
                                                          fontFamily: 'Quicksand',
                                                          fontSize: uniHeight(context)*.24,//14.0,
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      Text(' (not available)',
                                                        style: TextStyle(
                                                          color: Colors.black54,
                                                          fontFamily: 'Quicksand',
                                                          fontSize: uniHeight(context)*.18,//14.0,
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                  Text('carry heavy loads',
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                      fontFamily: 'Quicksand',
                                                      fontSize: uniHeight(context)*.2,//12.0,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                              Icon(
                                                Icons.check_circle,
                                                color: _color1,
                                              ),
                                            ]
                                        ),
                                      ]
                                  )
                              ),
                            )
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.26, vertical: MediaQuery.of(context).size.height * 0.020),
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50.0)),
                  textColor: Colors.white,
                  color: Color(0xff00A8E5),
                  child: Text('RIDE NOW',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color:Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    if(_selected != ""){
                      rideScooter();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RentScooter()),
                      );
                    }
                    else{
                      Fluttertoast.showToast(msg: "Please select model of scooter.",toastLength: Toast.LENGTH_SHORT);
                    }
                  }
              ),
            ),
          ],
        )
    );
  }

  Widget _yami(){
    return Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: _visible2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 7, child: SizedBox(),),
            Flexible(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: uniWidth(context)*1.2),//const EdgeInsets.symmetric(horizontal: 50.0),
                child: Card(
                  color: Color(0xFFFFFFFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(uniWidth(context)*.1),//const EdgeInsets.all(10.0),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left:10, top:10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Models in ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Quicksand',
                                    fontSize: uniHeight(context)*.25,//15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(_station,
                                  style: TextStyle(
                                    color: Color(0xff00A8E5),
                                    fontFamily: 'Quicksand',
                                    fontSize: uniHeight(context)*.25,//15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ]
                          ),
                        ),
                        Theme(
                            data: ThemeData(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                            child:
                            InkWell(
                              onTap: () {
                                setState((){

                                });
                              },
                              child: FlatButton(
                                  child: Table(
                                      //border: TableBorder.all(),
                                      columnWidths: {
                                        0: FlexColumnWidth(.15),
                                        1: FlexColumnWidth(.40),
                                        2: FlexColumnWidth(.1)
                                      },
                                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                      children: [
                                        TableRow(
                                            children: [
                                              Container(height: uniHeight(context)*.3,),
                                              Container(height: uniHeight(context)*.3,),
                                              Container(height: uniHeight(context)*.3,)
                                            ]
                                        ),
                                        TableRow(
                                            children: [
                                              Icon(Icons.electric_scooter_rounded,
                                                color: Colors.black54,
                                                size: uniWidth(context)*.8,//,
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text('PHOENIX',
                                                        style: TextStyle(
                                                          color: Colors.black54,
                                                          fontFamily: 'Quicksand',
                                                          fontSize: uniHeight(context)*.24,//14.0,
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      Text(' (not available)',
                                                        style: TextStyle(
                                                          color: Colors.black54,
                                                          fontFamily: 'Quicksand',
                                                          fontSize: uniHeight(context)*.18,//14.0,
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                  Text('regular scooter',
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                      fontFamily: 'Quicksand',
                                                      fontSize: uniHeight(context)*.2,//12.0,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                              Icon(
                                                Icons.check_circle,
                                                color: _color,
                                              ),
                                            ]
                                        ),
                                      ]
                                  )
                              ),
                            )
                        ),

                        Theme(
                            data: ThemeData(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                            child:
                            InkWell(
                              onTap: () {
                                setState((){
                                  _selected = "Yami";
                                  _color1 = Color(0xff00A8E5) ;
                                  _color = Colors.white ;
                                });
                              },
                              child: FlatButton(
                                  child: Table(
                                      //border: TableBorder.all(),
                                      columnWidths: {
                                        0: FlexColumnWidth(.15),
                                        1: FlexColumnWidth(.40),
                                        2: FlexColumnWidth(.1)
                                      },
                                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                      children: [
                                        TableRow(
                                            children: [
                                              Container(height: uniHeight(context)*.3,),
                                              Container(height: uniHeight(context)*.3,),
                                              Container(height: uniHeight(context)*.3,)
                                            ]
                                        ),
                                        TableRow(
                                            children: [
                                              Icon(Icons.electric_scooter_rounded,
                                                color: Color(0xff00A8E5),
                                                size: uniWidth(context)*.8,//,
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('YAMI',
                                                    style: TextStyle(
                                                      color: Color(0xff00A8E5),
                                                      fontFamily: 'Quicksand',
                                                      fontSize: uniHeight(context)*.24,//14.0,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text('carry heavy loads',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Quicksand',
                                                      fontSize: uniHeight(context)*.2,//12.0,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                              Icon(
                                                Icons.check_circle,
                                                color: _color1,
                                              ),
                                            ]
                                        ),
                                      ]
                                  )
                              ),
                            )
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.26, vertical: MediaQuery.of(context).size.height * 0.020),
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50.0)),
                  textColor: Colors.white,
                  color: Color(0xff00A8E5),
                  child: Text('RIDE NOW',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color:Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    if(_selected != ""){
                      rideScooter();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RentScooter()),
                      );
                    }
                    else{
                      Fluttertoast.showToast(msg: "Please select model of scooter.",toastLength: Toast.LENGTH_SHORT);
                    }
                  }
              ),
            ),
          ],
        )
    );
  }

  Widget _hasboth(){
    return Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: _visible3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 7, child: SizedBox(),),
            Flexible(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: uniWidth(context)*1.2),//const EdgeInsets.symmetric(horizontal: 50.0),
                child: Card(
                  color: Color(0xFFFFFFFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(uniWidth(context)*.1),//const EdgeInsets.all(10.0),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left:10, top:10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Models in ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Quicksand',
                                    fontSize: uniHeight(context)*.25,//15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(_station,
                                  style: TextStyle(
                                    color: Color(0xff00A8E5),
                                    fontFamily: 'Quicksand',
                                    fontSize: uniHeight(context)*.25,//15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ]
                          ),
                        ),
                        Theme(
                            data: ThemeData(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                            child:
                            InkWell(
                              onTap: () {
                                setState((){
                                  _selected = "Phoenix";
                                  _color = Color(0xff00A8E5) ;
                                  _color1 = Colors.white ;
                                });
                              },
                              child: FlatButton(
                                  child: Table(
                                    //border: TableBorder.all(),
                                      columnWidths: {
                                        0: FlexColumnWidth(.15),
                                        1: FlexColumnWidth(.40),
                                        2: FlexColumnWidth(.1)
                                      },
                                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                      children: [
                                        TableRow(
                                            children: [
                                              Container(height: uniHeight(context)*.3,),
                                              Container(height: uniHeight(context)*.3,),
                                              Container(height: uniHeight(context)*.3,)
                                            ]
                                        ),
                                        TableRow(
                                            children: [
                                              Icon(Icons.electric_scooter_rounded,
                                                color: Color(0xff00A8E5),
                                                size: uniWidth(context)*.8,//,
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('PHOENIX',
                                                    style: TextStyle(
                                                      color: Color(0xff00A8E5),
                                                      fontFamily: 'Quicksand',
                                                      fontSize: uniHeight(context)*.24,//14.0,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text('regular scooter',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Quicksand',
                                                      fontSize: uniHeight(context)*.2,//12.0,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                              Icon(
                                                Icons.check_circle,
                                                color: _color,
                                              ),
                                            ]
                                        ),
                                      ]
                                  )
                              ),
                            )
                        ),

                        Theme(
                            data: ThemeData(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                            child:
                            InkWell(
                              onTap: () {
                                setState((){
                                  _selected = "Yami";
                                  _color1 = Color(0xff00A8E5) ;
                                  _color = Colors.white ;
                                });
                              },
                              child: FlatButton(
                                  child: Table(
                                    //border: TableBorder.all(),
                                      columnWidths: {
                                        0: FlexColumnWidth(.15),
                                        1: FlexColumnWidth(.40),
                                        2: FlexColumnWidth(.1)
                                      },
                                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                      children: [
                                        TableRow(
                                            children: [
                                              Container(height: uniHeight(context)*.3,),
                                              Container(height: uniHeight(context)*.3,),
                                              Container(height: uniHeight(context)*.3,)
                                            ]
                                        ),
                                        TableRow(
                                            children: [
                                              Icon(Icons.electric_scooter_rounded,
                                                color: Color(0xff00A8E5),
                                                size: uniWidth(context)*.8,//,
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('YAMI',
                                                    style: TextStyle(
                                                      color: Color(0xff00A8E5),
                                                      fontFamily: 'Quicksand',
                                                      fontSize: uniHeight(context)*.24,//14.0,
                                                    ),
                                                  ),
                                                  Text('carry heavy loads',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Quicksand',
                                                      fontSize: uniHeight(context)*.2,//12.0,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                              Icon(
                                                Icons.check_circle,
                                                color: _color1,
                                              ),
                                            ]
                                        ),
                                      ]
                                  )
                              ),
                            )
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.26, vertical: MediaQuery.of(context).size.height * 0.020),
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50.0)),
                  textColor: Colors.white,
                  color: Color(0xff00A8E5),
                  child: Text('RIDE NOW',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color:Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    if(_selected != ""){
                      rideScooter();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RentScooter()),
                      );
                    }
                    else{
                      Fluttertoast.showToast(msg: "Please select model of scooter.",toastLength: Toast.LENGTH_SHORT);
                    }
                  }
              ),
            ),
          ],
        )
    );
  }
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
        body: SafeArea(
            child: Stack(
                children: [
                  Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GoogleMap(
                            onMapCreated: _onMapCreated,
                            markers: _markers,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(10.295235, 123.880835),
                              zoom: 18.5,
                            ),
                          ),
                        ),
                      ]
                  ),
                  _none(),
                  _phoenix(),
                  _yami(),
                  _hasboth(),
                ]
            )
        )
    );
  }
}


