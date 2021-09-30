import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
<<<<<<< Updated upstream:lib/sign_in.dart
import 'sign_up.dart';
import 'new_user.dart';
=======
import 'package:skrrt_app/home_page.dart';
import 'package:skrrt_app/utils.dart';
import 'package:skrrt_app/widgets/ProgressDialog.dart';
import 'sign-up-module.dart';
>>>>>>> Stashed changes:lib/login-module.dart
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'forgot_pass.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _username;
  String _password;
  var session = FlutterSession();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();

  bool viewPass = true;
  double btmpad = 0;

<<<<<<< Updated upstream:lib/sign_in.dart
  void userLogin() async{
    var url = "http://192.168.1.4/skrrt/login.php";
    var data = {
    "username": _user.text,
    "pass":_pass.text,
    };
=======
  bool disconnected = false;
  bool errorCred = false;
>>>>>>> Stashed changes:lib/login-module.dart

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
                      MaterialPageRoute(builder: (context) => Home()),
                    )
                  }
              });
        }
      } on PlatformException catch (err) {
        // Handle err
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
      validator: (username) {
        if (username.isEmpty) {
          errorCred = true;
          return 'Email is required.';
        } else {
          errorCred = false;
          return null;
        }
      },
      onSaved: (username) => _username = username,
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
<<<<<<< Updated upstream:lib/sign_in.dart
          Padding(
            padding: EdgeInsets.only(bottom: btmpad),
            child:
            IconButton(
                icon: IconButton(
                    icon: Icon(Icons.visibility,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        viewPass = !viewPass;
                      });
                    }
                )
            ),
          )
    ]
    );
=======
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
            errorCred = true;
            setState(() {
              btmpad = 25;
            });
            return 'Password is required.';
          } else {
            errorCred = false;
            return null;
          }
        },
        onSaved: (password) => _password = password,
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
>>>>>>> Stashed changes:lib/login-module.dart
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
<<<<<<< Updated upstream:lib/sign_in.dart
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
=======
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    onPressed: () async {
                                      final result = await Connectivity()
                                          .checkConnectivity();
                                      if (result != ConnectivityResult.none) {
                                        if (errorCred == false) {
>>>>>>> Stashed changes:lib/login-module.dart
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
<<<<<<< Updated upstream:lib/sign_in.dart
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
=======
                                      }),
                                )
>>>>>>> Stashed changes:lib/login-module.dart
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
