import 'package:flutter/material.dart';
class NavPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 2, child: SizedBox(),),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Card(
              color: Color(0xFFFFFFFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                width: double.infinity,
                height: 70.0,
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.warning_amber_rounded,
                      color: Color(0xFFDC0505),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Scooter is not parked in designated parking spot.',
                          style: TextStyle(
                            color: Color(0xFFDC0505),
                            fontFamily: 'Quicksand',
                            fontSize: 14.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text('Please park in marked places on the map.',
                          style: TextStyle(
                            color: Color(0xFFDC0505),
                            fontFamily: 'Quicksand',
                            fontSize: 14.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Icon(Icons.volume_up_rounded,
                      color: Color(0xFF0E0E0E),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(flex: 1, child: SizedBox(),),
      ],
    );
  }
}
