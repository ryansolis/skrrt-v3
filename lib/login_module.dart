import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skrrt_app/home_module.dart';
import 'package:skrrt_app/signup_module.dart';
import 'package:skrrt_app/widgets/ProgressDialog.dart';
import 'package:skrrt_app/widgets/utils.dart';
import 'new_user.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'forgot_pass.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginController createState() => _LoginController();
}

class _LoginController extends State<LoginView> {
  //String _username;
  //String _password;
  var session = FlutterSession();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();

  bool viewPass = true;
  double btmpad = 0;

  bool disconnected = false;
  bool errorCred = false;

  // void userLogin() async{
  //   var url = "http://192.168.1.4/skrrt/login.php";
  //   var data = {
  //   "username": _user.text,
  //   "pass":_pass.text,
  //   };

  void showConnectivitySnackBar(ConnectivityResult result) {
    final hasInternet = result != ConnectivityResult.none;
    final message = hasInternet
        ? 'You now have your connection back'
        : 'No internet connection';
    final color =
        hasInternet ? Color.fromARGB(255, 0x00, 0xA8, 0xE5) : Colors.red;

    Utils.showTopSnackBar(context, message, color);
  }

  void userLogin() async {
    // var url = "http://192.168.1.12/skrrt/login.php";
    // var data = {
    //   "username": _user.text,
    //   "pass": _pass.text,
    // };

    // var res = await http.post(url, body: data);
    // if (jsonDecode(res.body) == "No account") {
    //   Fluttertoast.showToast(
    //       msg: "Account doesn't exist!", toastLength: Toast.LENGTH_SHORT);
    // } else {
    //   if (jsonDecode(res.body) == "false") {
    //     Fluttertoast.showToast(
    //         msg: "Incorrect password", toastLength: Toast.LENGTH_SHORT);
    //   } else {
    //     //print(jsonDecode(res.body));
    //     List data = jsonDecode(res.body);
    //     var userId = (data[0]["userID"]);
    //     await session.set("token", userId);
    //     print(userId);
    //     Navigator.of(context).pushNamed('tohome');
    //   }
    // }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        status: 'Logging you in',
      ),
    );

    if (errorCred != true) {
      try {
        final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
          email: _email.text,
          password: _pass.text,
        ))
            .user;

        if (user != null) {
          DatabaseReference userRef =
              FirebaseDatabase.instance.reference().child('users/${user.uid}');

          userRef.once().then((DataSnapshot snapshot) => {
                if (snapshot.value != null)
                  {
                    Navigator.pop(context),
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeView()),
                    )
                  }
              });
        }
      } catch (err) {
        // other types of Exceptions
      }
    }
  }

  Widget _buildUsername() {
    return TextFormField(
      controller: _email,
      decoration: InputDecoration(
          hintText: 'Email',
          hintStyle: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 16.0,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.email_outlined,
              color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
              size: 15,
            ),
          )),
      style: TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 16.0,
        color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
      ),
      keyboardType: TextInputType.text,
      validator: (email) {
        if (email.isEmpty) {
          errorCred = true;
          return 'Email is required.';
        } else {
          errorCred = false;
          return null;
        }
      },
      //onSaved: (email) => _email = email as TextEditingController,
    );
  }

  Widget _buildPassword() {
    return Stack(alignment: Alignment.centerRight, children: <Widget>[
      TextFormField(
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
              Icons.lock_rounded,
              color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
              size: 15,
            ),
          ),
        ),
        style: TextStyle(
          fontFamily: 'Quicksand',
          fontSize: 16.0,
          color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
        ),
        keyboardType: TextInputType.text,
        obscureText: viewPass,
        validator: (password) {
          if (password.isEmpty) {
            setState(() {
              btmpad = 25;
            });
            return 'Password is required.';
          } else
            return null;
        },
        //onSaved: (password) => _pass = password as TextEditingController,
      ),
      Padding(
        padding: EdgeInsets.only(bottom: btmpad),
        child: IconButton(
            icon: Icon(
              Icons.visibility,
              size: 20,
            ),
            onPressed: () {
              setState(() {
                viewPass = !viewPass;
              });
            }),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(left: 60.0, right: 60.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //SizedBox(height: MediaQuery.of(context).size.height * 0.0001,),
                    Container(
                        child: Column(children: [
                      Image(
                        image: AssetImage("assets/skrrt_logo1.jpg"),
                        height: 100,
                        width: 100,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      Text('SIGN IN',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                            color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
                          )),
                    ])),
                    Container(
                        child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _buildUsername(),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                _buildPassword(),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(12.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0)),
                                      primary: Color(0xff00A8E5),
                                    ),
                                    child: Text(
                                      ''
                                      'LOG IN',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    onPressed: () async {
                                      final result = await Connectivity()
                                          .checkConnectivity();
                                      if (result != ConnectivityResult.none) {
                                        if (_formKey.currentState.validate()) {
                                          _formKey.currentState.save();
                                          userLogin();
                                        }

                                        if (disconnected == true) {
                                          showConnectivitySnackBar(result);
                                          disconnected = false;
                                        }
                                      } else {
                                        showConnectivitySnackBar(result);
                                        disconnected = true;
                                      }
                                    }),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                Center(
                                  child: TextButton(
                                      child: Text(
                                        'Forgot Password',
                                        style: TextStyle(
                                          fontFamily: 'Quicksand',
                                          fontSize: 16.0,
                                          decoration: TextDecoration.underline,
                                          letterSpacing: 1.0,
                                          color: Color.fromARGB(
                                              255, 0x00, 0xA8, 0xE5),
                                        ),
                                      ),
                                      onPressed: () async {
                                        final result = await Connectivity()
                                            .checkConnectivity();
                                        if (result != ConnectivityResult.none) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ForgotPass()),
                                          );
                                          if (disconnected == true) {
                                            showConnectivitySnackBar(result);
                                            disconnected = false;
                                          }
                                        } else {
                                          showConnectivitySnackBar(result);
                                          disconnected = true;
                                        }
                                      }),
                                )
                              ],
                            ))),
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
                            child: Text(
                              "Sign Up Now",
                              style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 16.0,
                                letterSpacing: 1.0,
                                color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
                              ),
                            ),
                            onPressed: () async {
                              final result =
                                  await Connectivity().checkConnectivity();
                              if (result != ConnectivityResult.none) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpView()),
                                );
                                if (disconnected == true) {
                                  showConnectivitySnackBar(result);
                                  disconnected = false;
                                }
                              } else {
                                showConnectivitySnackBar(result);
                                disconnected = true;
                              }
                            }),
                      ],
                    ))
                  ],
                ),
              )),
        )));
  }
}
