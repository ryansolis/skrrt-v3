import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'sign_up.dart';
import 'new_user.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _username;
  String _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _user = TextEditingController();
  TextEditingController _pass = TextEditingController();

  void userLogin() async{
    var url = "http://192.168.1.11/skrrt/login.php";
    var data = {
    "username": _user.text,
    "pass":_pass.text,
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
        print(jsonDecode(res.body));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewUser()),
        );
      }
    }
  }

  Widget _buildUsername(){
    return TextFormField(
      controller: _user,
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
      style: TextStyle(color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),),
      keyboardType: TextInputType.text,
      validator: (username){
//        Pattern pattern =
//            r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
//        RegExp regex = new RegExp(pattern);
        if (username.isEmpty) {
          return 'Username is required.';
        }
//        else if (!regex.hasMatch(username))
//          return 'Invalid Username.';
        else
          return null;
      },
      onSaved: (username)=> _username = username,
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      controller: _pass,
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: TextStyle(
          fontFamily: 'Quicksand',
          fontSize: 16.0,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(right: 15),
          child: Icon(
            Icons.lock_rounded ,
            color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
            size: 15,
          ),
        ),
      ),
      style: TextStyle(color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),),
      keyboardType: TextInputType.text,
      obscureText: true,
      validator: (password){
//        Pattern pattern =
//            r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
//        RegExp regex = new RegExp(pattern);
        if (password.isEmpty) {
          return 'Password is required.';
        }
//        else if (!regex.hasMatch(password))
//          return 'Invalid Password.';
        else
          return null;
      },
      onSaved: (password)=> _password = password,
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
                                      'SIGN IN',
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
                                  _buildUsername(),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                                  _buildPassword(),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                                  RaisedButton(
                                      padding: EdgeInsets.all(12.0),
                                      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50.0)),
                                      color: Color(0xff00A8E5),
                                      disabledColor: Colors.blue,//add this to your code
                                      child: Text(''
                                          'LOG IN',
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
                                  Center(
                                    child: Text(
                                      'Forgot Password',
                                      style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        fontSize: 16.0,
                                        decoration: TextDecoration.underline,
                                        letterSpacing: 1.0,
                                        color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            )
                        ),
                        //SizedBox( height: MediaQuery.of(context).size.height * 0.1,),
                        Container(
                            child: Column(
                              children: [
                                Text(
                                  "Don't have any account?",
                                  style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontSize: 16.0,
                                    letterSpacing: 1.0,
                                    color: Colors.black,
                                  ),
                                ),
                                TextButton(
                                    child: Text("Sign Up Now",
                                      style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        fontSize: 16.0,
                                        letterSpacing: 1.0,
                                        color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => SignUp()),
                                      );
                                    }
                                ),
                              ],
                            )
                        )
                      ],
                    ),
                  )
              ),
            )
        )
    );
  }
}