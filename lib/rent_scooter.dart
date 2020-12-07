import 'dart:ui';
import 'dart:async';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:http/http.dart' as http;
import 'sidebar_page.dart';
import 'navigation.dart';
import 'dart:convert';


class RentScooter extends StatefulWidget {

  @override
  _RentScooterState createState() => _RentScooterState();

}

class _RentScooterState extends State<RentScooter> {
  var session = FlutterSession();
  //var tester=2;
  String _sctID="",model="",ridecount="",station="",qrcode="",desc="",power="",mah="",speed="",available="";
  List scoot;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _cameraScanResult = '';

  Future _scan() async {
    //Start scan-blocking until scan
    String barcode = await scanner.scan();
    _cameraScanResult = barcode;
    toNavigation(context);
  }
  Future _testID() async{
    //print("hello");

    var url = "http://192.168.1.9/skrrt/chooseSctr.php";
    var scooterID = await session.get("scooter");
    var data={
      "scooter": scooterID.toString(),
    };
    var res = await http.post(url,body: data);
    print(data);
    //print(jsonDecode(res.body));
    scoot = jsonDecode(res.body);
    print("should: "+'$scoot');
    _sctID=scoot[0]['scooterID'];
    model = scoot[0]['model'];
    ridecount=scoot[0]['ridecount'].toString();
    qrcode=scoot[0]['qrcode'].toString();
    desc=scoot[0]['desc'].toString();
    power=scoot[0]['power'].toString();
    mah=scoot[0]['mah'].toString();
    station = scoot[0]['station'].toString();
    speed=scoot[0]['speed'].toString();
    available=scoot[0]['available'].toString();
    await session.set("scooter",scooterID);
    setState(() {});
  }
  void toNavigation(BuildContext context){
    if (_cameraScanResult.isNotEmpty){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Navigation()),
      );
    }
  }

  @override
  initState() {
    super.initState();
    _testID();
    //setState(() {});
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, top: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                              Text(model,//'Phoenix',
                                  style: TextStyle(
                                    color: Color(0xFF0E0E0E),
                                    fontFamily: 'Quicksand',
                                    fontSize: MediaQuery.of(context).size.height*.06,//30.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                              ),

                        /*
                        Text('Phoenix',
                          style: TextStyle(
                            color: Color(0xFF0E0E0E),
                            fontFamily: 'Quicksand',
                            fontSize: MediaQuery.of(context).size.height*.06,//30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),*/
                        SizedBox(width: 15.0,),
                        /*
                        Text('1 available',
                          style: TextStyle(
                            color: Color(0xFFA62415),
                            fontFamily: 'Quicksand',
                            fontSize: MediaQuery.of(context).size.height*.03,//15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                        */
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Text('Rent Scooter',
                      style: TextStyle(
                        color: Color(0xFF7D7D7D),
                        fontFamily: 'Quicksand',
                        fontSize: MediaQuery.of(context).size.height*.04,//25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
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
                                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                                      child: Text('Details',
                                        style: TextStyle(
                                          color: Color(0xFF0E0E0E),
                                          fontFamily: 'Quicksand',
                                          fontSize: MediaQuery.of(context).size.height*.05,//30.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(desc,
                                      style: TextStyle(
                                        color: Color(0xFF0E0E0E),
                                        fontFamily: 'Quicksand',
                                        fontSize: MediaQuery.of(context).size.height*.025,//15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text('    (max: 45kg)',
                                      style: TextStyle(
                                        color: Color(0xFF0E0E0E),
                                        fontFamily: 'Quicksand',
                                        fontSize: MediaQuery.of(context).size.height*.025,//15.0,
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
                                                  Text(power,
                                                    style: TextStyle(
                                                      color: Color(0xFF0E0E0E),
                                                      fontFamily: 'Quicksand',
                                                      fontSize: MediaQuery.of(context).size.height*.025,//15.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text('watt',
                                                    style: TextStyle(
                                                      color: Color(0xFF7D7D7D),
                                                      fontFamily: 'Quicksand',
                                                      fontSize: MediaQuery.of(context).size.height*.025,//15.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
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
                                                  Text(mah,
                                                    style: TextStyle(
                                                      color: Color(0xFF0E0E0E),
                                                      fontFamily: 'Quicksand',
                                                      fontSize: MediaQuery.of(context).size.height*.025,//15.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text('mah',
                                                    style: TextStyle(
                                                      color: Color(0xFF7D7D7D),
                                                      fontFamily: 'Quicksand',
                                                      fontSize: MediaQuery.of(context).size.height*.025,//15.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
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
                                                  Text(speed,
                                                    style: TextStyle(
                                                      color: Color(0xFF0E0E0E),
                                                      fontFamily: 'Quicksand',
                                                      fontSize: MediaQuery.of(context).size.height*.025,//15.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text('km/h',
                                                    style: TextStyle(
                                                      color: Color(0xFF7D7D7D),
                                                      fontFamily: 'Quicksand',
                                                      fontSize: MediaQuery.of(context).size.height*.025,//15.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
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
                                                  Text(qrcode,//.substring(0,4)+"\n"+qrcode.substring(4),
                                                    style: TextStyle(
                                                      color: Color(0xFF0E0E0E),
                                                      fontFamily: 'Quicksand',
                                                      fontSize: MediaQuery.of(context).size.height*.025,//15.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text('code',
                                                    style: TextStyle(
                                                      color: Color(0xFF7D7D7D),
                                                      fontFamily: 'Quicksand',
                                                      fontSize: MediaQuery.of(context).size.height*.025,//15.0,
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
                        height: MediaQuery.of(context).size.height*.24,
                        left: -50.0,
                        top: 25.0,
                        child: Image(image: AssetImage('assets/scooter_phoenix.png'))
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
                                  fontSize: MediaQuery.of(context).size.height*.035,//25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(station,
                                      style: TextStyle(
                                        color: Color(0xFF0E0E0E),
                                        fontFamily: 'Quicksand',
                                        fontSize: MediaQuery.of(context).size.height*.03,//20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text('station',
                                      style: TextStyle(
                                        color: Color(0xFF7D7D7D),
                                        fontFamily: 'Quicksand',
                                        fontSize: MediaQuery.of(context).size.height*.03,//20.0,
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
                            fontSize: MediaQuery.of(context).size.height*.028,//18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Note: Every extra 5 mins will add P5.00 to your account.',
                          style: TextStyle(
                            color: Color(0xFFFB4D4D),
                            fontFamily: 'Quicksand',
                            fontSize: MediaQuery.of(context).size.height*.025,//15.0,
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
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.3, vertical: 14.0),
                          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50.0)),
                          textColor: Colors.white,
                          color: Color(0xff00A8E5),
                          child: Text('SCAN NOW',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color:Colors.white,
                              fontSize: MediaQuery.of(context).size.height*.026,//16,
                            ),
                          ),
                          onPressed: () {
                            if(available=="1") {
                              //_scan();
                              //if (_cameraScanResult.isNotEmpty){
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Navigation()),
                              );
                            }
                            else{
                              Fluttertoast.showToast(msg: "Scooter is currently in use, please choose another model.",toastLength: Toast.LENGTH_SHORT);
                            }
                            //}
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
