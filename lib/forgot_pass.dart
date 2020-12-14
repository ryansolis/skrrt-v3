import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'sign_up.dart';
import 'new_user.dart';
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
  var session = FlutterSession();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _idno = TextEditingController();
  TextEditingController _no = TextEditingController();

  void userLogin() async{
    var url = "http://192.168.1.4/skrrt/recoveracc.php";
    var data = {
      "id": _idno.text,
      "mobile":_no.text,
    };

    var res = await http.post(url,body: data);
    if(jsonDecode(res.body) == "No account"){
      Fluttertoast.showToast(msg: "Account doesn't exist!",toastLength: Toast.LENGTH_SHORT);
    }
    else{
      if(jsonDecode(res.body) == "false"){
        Fluttertoast.showToast(msg: "Incorrect password",toastLength: Toast.LENGTH_SHORT);
      }
      else{
        //print(jsonDecode(res.body));
        List data = jsonDecode(res.body);
        var userId = (data[0]["userID"]);
        await session.set("token", userId);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewUser()),
        );
      }
    }
  }

  Widget _buildID(){
    return TextFormField(
      controller: _idno,
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
      validator: (id){
        if (id.isEmpty) {
          return 'ID Number is required.';
        }
        else
          return null;
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
      keyboardType: TextInputType.text,
      obscureText: true,
      validator: (phone){
        if (phone.isEmpty) {
          return 'Phone Number is required.';
        }
        else
          return null;
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //SizedBox(height: MediaQuery.of(context).size.height * 0.0001,),
                        Container(
                            child: Column(
                                children: [
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
                                  children: [
                                    _buildID(),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                                    _buildPhone(),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
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
                                            userLogin();
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