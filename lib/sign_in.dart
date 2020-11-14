import 'package:flutter/material.dart';
import 'sign_up.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _username;
  String _password;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget _buildUsername(){
    return TextFormField(
      decoration: InputDecoration(
              hintText: 'Username',
              hintStyle: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 16.0,
                color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
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
      keyboardType: TextInputType.text,
      /*
      validator: (String value){
        if(value.isEmpty){
          return 'Username is Required.';
        }
        if(!RegExp(r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$').hasMatch(value)){
          return 'Please enter a valid Username.';
        }
        else return null;
      },
      onSaved: (String value) {
        _username = value;
      },*/
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 16.0,
            color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
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

      keyboardType: TextInputType.text,
      obscureText: true,
      /*
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is Required.';
        }
        else return null;
      },
      onSaved: (String value) {
        _password = value;
      },*/
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
                child: Padding(
                  padding: EdgeInsets.only(left: 60.0, right:60.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        color: Colors.white,
                        height: 10.0,
                      ),
                      Container(
                          child: Column(
                              children: [
                                Image(
                                  image: AssetImage("assets/skrrt_logo1.jpg"),
                                  height: 100,
                                  width: 100,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
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
                                SizedBox(
                                  height: 30,
                                ),
                              ]
                          )
                      ),

                      Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _buildUsername(),
                              SizedBox(height:10),
                              _buildPassword(),
                              SizedBox(height:30),
                              RaisedButton(
                                  padding: EdgeInsets.all(12.0),
                                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50.0)),
                                  textColor: Colors.white,
                                  color: Color(0xff00A8E5),
                                  child: Text(''
                                      'LOG IN',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color:Colors.white,
                                      fontSize: 16,
                                    ),

                                  ),
                                  onPressed: () {
                                    /*
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SignUp()),
                                    );*/
                                  }
                                /*
                            onPressed: () => {
                              if(!formKey.currentState.validate()){
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => LaunchPage()),
                                )
                              }
                              else{
                                formKey.currentState.save()
                              }
                            }*/
                              ),
                              SizedBox(height:10),
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
                      ),
                      SizedBox(
                        height: 70,
                      ),
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