import 'package:flutter/material.dart';

class AppbarImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 8, 15, 2),
            height: MediaQuery.of(context).size.height*.8,
            width: MediaQuery.of(context).size.width*.8,
            child: Image(
              alignment: Alignment.centerRight,
              image: AssetImage('assets/jess-brobrero.png'),
            ),
          ),
        ),
      ),
    );
  }
}
