import 'package:flutter/material.dart';

class AppbarImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        //color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 8, 0, 2),
              height: 60,
              width: 60,
              child: Image(
                image: AssetImage('assets/jess-brobrero.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
