import 'package:flutter/material.dart';
import 'home_page.dart';

class NewUser extends StatefulWidget {
  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(left: 60.0, right: 60.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image(
                      image: AssetImage("assets/skrrt_logo.png"),
                      height: 75,
                      width: 75,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                        'Your on-campus scooter on the go',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16.0,

                          //fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                          color: Colors.white,
                        )
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Image(
                      image: AssetImage("assets/useronscooter.png"),
                      height: 175,
                      width: 200,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        'Want to quickly arrive at your destination?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16.0,

                          //fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                          color: Colors.white,
                        )
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    RaisedButton(
                        padding: EdgeInsets.all(12.0),
                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50.0)),
                        color: Colors.white,
                        disabledColor: Colors.grey,//add this to your code
                        child: Text(''
                            'RIDE NOW',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color:Color(0xff00A8E5),
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
                          /*
                                    if(!formKey.currentState.validate()){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => LaunchPage()),
                                      )
                                    }
                                    else{
                                      formKey.currentState.save()
                                    }*/
                        }
                    ),
                    SizedBox(height:10),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}