import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skrrt_app/newpass.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ForgotPass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  String _idnum;
  String _phonenum;
  String _username;
  bool viewPass = true;
  double btmpad = 0;

  var session = FlutterSession();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _idno = TextEditingController();
  TextEditingController _no = TextEditingController();
  TextEditingController _user = TextEditingController();
  TextEditingController _pass = TextEditingController();

  void recoverAcc() async{
    var url = "http://192.168.1.17/skrrt/recoveracc.php";
    var data = {
      "username": _username,
      "id": _idno.text,
      "mobile":_no.text,
    };
    print(data);
    var res = await http.post(url,body: data);
    print(jsonDecode(res.body));
    if(jsonDecode(res.body) == "No account found"){
      Fluttertoast.showToast(msg: "Account doesn't exist!",toastLength: Toast.LENGTH_SHORT);
    }

    else if (jsonDecode(res.body) == "Success"){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewPass()),
        );
    }
    else{
      Fluttertoast.showToast(msg: "Wrong information. No account found.",toastLength: Toast.LENGTH_SHORT);
    }

    await session.set("id", _idno.text);
  }

  Widget _buildUsername(){
    return TextFormField(
      controller: _user,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          hintText: 'Username',
          hintStyle: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 16.0,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.face_rounded,
              color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
              size: 15,
            ),
          )
      ),
      style: TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 16.0,
        color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),),
      keyboardType: TextInputType.text,
      validator: (username){
        if (username.isEmpty) {
          return 'Username is required.';
        }
        else
          return null;
      },
      onSaved: (username)=> _username = username,
    );
  }

  Widget _buildID(){
    return TextFormField(
      controller: _idno,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          hintText: 'ID Number',
          hintStyle: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 16.0,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.contact_mail,
              color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
              size: 15,
            ),
          )
      ),
      style: TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 16.0,
        color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),),
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'ID No. is Required.';
        }
        else if(!RegExp('[0-9]{2}[-][0-9]{4}[-][0-9]{3}\$').hasMatch(value)){
          return 'Must be in correct format (ex: 12-2525-969)';
        }
        else return null;
      },
      onSaved: (id)=> _idnum = id,
    );
  }

  Widget _buildPhone() {
    return TextFormField(
      controller: _no,
      decoration: InputDecoration(
        hintText: 'Phone Number',
        hintStyle: TextStyle(
          fontFamily: 'Quicksand',
          fontSize: 16.0,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(right: 15),
          child: Icon(
            Icons.settings_cell_rounded ,
            color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
            size: 15,
          ),
        ),
      ),
      style: TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 16.0,
        color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),),
      keyboardType: TextInputType.number,
      validator: (value){
        if(value.isEmpty){
          return 'Phone No. is required.';
        }
        else if(!RegExp('[0][9][0-9]{9}\$').hasMatch(value)){
          return 'Must begin with 09 first and must only be 11 digits.';
        }
        else return null;
      },
      onSaved: (phone)=> _phonenum = phone,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.only(left: 60.0, right:60.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //SizedBox(height: MediaQuery.of(context).size.height * 0.0001,),
                        Container(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                                  Image(
                                    image: AssetImage("assets/skrrt_logo1.jpg"),
                                    height: 100,
                                    width: 100,
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                                  Text(
                                      'RECOVER SKRRT ACCOUNT',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.0,
                                        color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
                                      )
                                  ),
                                ]
                            )
                        ),
                        Container(
                            child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.10,),
                                    _buildUsername(),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                                    _buildID(),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                                    _buildPhone(),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                                    RaisedButton(
                                        padding: EdgeInsets.all(12.0),
                                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50.0)),
                                        color: Color(0xff00A8E5),
                                        disabledColor: Colors.blue,//add this to your code
                                        child: Text(''
                                            'SUBMIT',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color:Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        onPressed: () {
                                          if(_formKey.currentState.validate()){
                                            _formKey.currentState.save();
                                            recoverAcc();
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(builder: (context) => NewPass()),
                                            // );
                                          }

                                        }
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                                  ],
                                )
                            )
                        ),
                        SizedBox( height: MediaQuery.of(context).size.height * 0.1,),
                      ],
                    ),
                  )
              ),
            )
        )
    );
  }
}