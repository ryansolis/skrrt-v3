import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skrrt_app/sign_in.dart';
import 'sign_up.dart';
import 'new_user.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class NewPass extends StatefulWidget {
  @override
  _NewPassState createState() => _NewPassState();
}

class _NewPassState extends State<NewPass> {

  var session = FlutterSession();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _pass1 = TextEditingController();
  TextEditingController _pass2 = TextEditingController();

  String _password1;
  String _password2;

  bool viewPass1 = true;
  double btmpad1 = 0;

  bool viewPass2 = true;
  double btmpad2 = 0;

  void newPass() async{
    var url = "http://192.168.1.4/skrrt/newpass.php";

    var id = await session.get("id");

    var data = {
      "id": id,
      "password": _pass1,
    };
    print(data);
    var res = await http.post(url,body: data);
    print(jsonDecode(res.body));
    if(jsonDecode(res.body) == "Success"){
      Fluttertoast.showToast(msg: "Successfully changed your password!.",toastLength: Toast.LENGTH_SHORT);
    }
  }

  Widget _buildPassword1() {
    return Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          TextFormField(
            controller: _pass1,
            decoration: InputDecoration(
              hintText: 'New Password',
              contentPadding: const EdgeInsets.all(15.0),
              hintStyle: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 16.0,
              ),
            ),
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 16.0,
              color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
            ),
            keyboardType: TextInputType.text,
            obscureText: viewPass1,
            validator: (password){
              if(password.isEmpty){
                return 'Password is required.';
              }
              else if(!RegExp('^[a-zA-Z0-9-]{6,}').hasMatch(password)){
                setState(() {
                  _pass1.text = password;
                  btmpad1 = 25;
                });
                return 'Length must be 6 characters or more.';
              }
              else return null;
            },
            onSaved: (password)=> _password1 = password,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: btmpad1),
            child:
            IconButton(
                icon: IconButton(
                    icon: Icon(Icons.visibility,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        viewPass1 = !viewPass1;
                      });
                    }
                )
            ),
          )
        ]
    );
  }

  Widget _buildPassword2() {
    return Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          TextFormField(
            controller: _pass2,
            decoration: InputDecoration(
              hintText: 'Re-enter Password',
              contentPadding: const EdgeInsets.all(15.0),
              hintStyle: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 16.0,
              ),
            ),
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 16.0,
              color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
            ),
            keyboardType: TextInputType.text,
            obscureText: viewPass2,
            validator: (password){
              if(password.isEmpty){
                return 'Password is required.';
              }
              else if(!RegExp('^[a-zA-Z0-9-]{6,}').hasMatch(password)){
                setState(() {
                  _pass2.text = password;
                  btmpad2 = 25;
                });
                return 'Length must be 6 characters or more.';
              }
              else return null;
            },
            onSaved: (password)=> _password2 = password,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: btmpad2),
            child:
            IconButton(
                icon: IconButton(
                    icon: Icon(Icons.visibility,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        viewPass2 = !viewPass2;
                      });
                    }
                )
            ),
          )
        ]
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
                                      'CHANGE PASSWORD',
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
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.07,),
                                    _buildPassword1(),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                                    _buildPassword2(),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                                    RaisedButton(
                                        padding: EdgeInsets.all(12.0),
                                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50.0)),
                                        color: Color(0xff00A8E5),
                                        disabledColor: Colors.blue,//add this to your code
                                        child: Text(''
                                            'CONFIRM',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color:Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        onPressed: () {
                                          if(_formKey.currentState.validate()){
                                              _formKey.currentState.save();
                                              if(_password1 == _password2){
                                                newPass();
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              }
                                              else{
                                                Fluttertoast.showToast(msg: "Wrong password entered.",toastLength: Toast.LENGTH_SHORT);
                                              }
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