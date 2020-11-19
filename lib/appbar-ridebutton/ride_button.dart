import 'package:flutter/material.dart';
import 'package:skrrt_app/home_page.dart';

class RideButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 70,
      child: FloatingActionButton(
        backgroundColor: Color(0xFF00A8E5),
          child: Text(
          'RIDE',
          style: TextStyle(
          color: Colors.white,
          fontFamily: 'Montserrat',
          //fontSize: 12
          ),
        ),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return HomeScreen();
          }));
        },
      ),
    );
  }
}
