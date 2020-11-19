import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'sidebar_page.dart';
import 'rent_scooter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Set<Marker> _markers ={};
  BitmapDescriptor mapMarker;
  BitmapDescriptor selectedMarker;
  bool _visible = false;
  bool _visible1 = false;

  @override
  void initState(){
    super.initState();
    setCustomMarker();
  }

  void setCustomMarker() async{
    selectedMarker = await getBitmapDescriptorFromAssetBytes("assets/skrrt_selected1.png", 200);
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
          position: LatLng(10.295666, 123.880472),
          icon: mapMarker,
        )
      );
      _markers.add(
          Marker(
            markerId: MarkerId('id-2'),
            position: LatLng(10.295235, 123.880835),
            icon: selectedMarker,
            infoWindow: InfoWindow(
              title: 'CIT Main Library',
              snippet: '2 Available'
            ),
            onTap: () {
                setState(() {
                  _visible = true;
                  _visible1 = false;
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
                  _visible1 = true;
                  _visible = false;
                });
              }
          )
      );
      _markers.add(
          Marker(
            markerId: MarkerId('id-4'),
            position: LatLng(10.295484, 123.880038),
            icon: mapMarker,
          )
      );
    });
  }
  Color _color = Colors.white;
  Color _color1 = Colors.white;

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
                  Visibility(
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: _visible,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(flex: 4, child: SizedBox(),),
                        Flexible(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50.0),
                            child: Card(
                              color: Color(0xFFFFFFFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text('Library Station',
                                              style: TextStyle(
                                                color: Color(0xff00A8E5),
                                                fontFamily: 'Quicksand',
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ]
                                      ),
                                    ),
                                    SizedBox(height:20),
                                    Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            setState((){
                                              _color = Color(0xff00A8E5) ;
                                              _color1 = Colors.white ;
                                            });
                                          },
                                          child: FlatButton(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Icon(Icons.electric_scooter_rounded,
                                                  color: Color(0xff00A8E5),
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('PHOENIX',
                                                      style: TextStyle(
                                                        color: Color(0xff00A8E5),
                                                        fontFamily: 'Quicksand',
                                                        fontSize: 14.0,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    Text('regular scooter',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Quicksand',
                                                        fontSize: 12.0,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                                Icon(Icons.check_circle,
                                                  color: _color,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                    ),
                                    Divider(
                                        color: Colors.grey
                                    ),
                                    Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            setState((){
                                              _color = Colors.white ;
                                              _color1 = Color(0xff00A8E5) ;
                                            });
                                          },
                                          child: FlatButton(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Icon(Icons.electric_scooter_rounded,
                                                  color: Color(0xff00A8E5),
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('    YAMI',
                                                      style: TextStyle(
                                                        color: Color(0xff00A8E5),
                                                        fontFamily: 'Quicksand',
                                                        fontSize: 14.0,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    Text('    carry heavy loads',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Quicksand',
                                                        fontSize: 12.0,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                                Icon(Icons.check_circle,
                                                  color: _color1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical:18),
                            child: RaisedButton(
                                padding: EdgeInsets.symmetric(horizontal:100),
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
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => RentScooter()),
                                );
                                }
                            ),
                          ),
                        ),
                        SizedBox(height:20),
                      ],
                    )
                  ),
                  Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: _visible1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(flex: 6, child: SizedBox(),),
                          Flexible(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 50.0),
                              child: Card(
                                color: Color(0xFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text('Main Canteen Station',
                                                style: TextStyle(
                                                  color: Color(0xff00A8E5),
                                                  fontFamily: 'Quicksand',
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ]
                                        ),
                                      ),
                                      SizedBox(height:20),
                                      Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              setState((){
                                                _color = Color(0xff00A8E5) ;
                                                _color1 = Colors.white ;
                                              });
                                            },
                                            child: FlatButton(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Padding(padding: EdgeInsets.only(bottom: 10),
                                                    child:
                                                    Icon(Icons.electric_scooter_rounded,
                                                      color: Color(0xff00A8E5),
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('PHOENIX',
                                                        style: TextStyle(
                                                          color: Color(0xff00A8E5),
                                                          fontFamily: 'Quicksand',
                                                          fontSize: 15.0,
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      Text('regular scooter',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'Quicksand',
                                                          fontSize: 14.0,
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                  Icon(Icons.check_circle,
                                                    color: _color,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical:18),
                              child: RaisedButton(
                                  padding: EdgeInsets.symmetric(horizontal:100),
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
                                    /*Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Navigation()),
                                );*/
                                  }
                              ),
                            ),
                          ),
                          SizedBox(height:20),
                        ],
                      )
                  ),
                ]
            )
        )
    );
  }
}


