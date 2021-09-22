import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';
// Now instantiate FlutterOtp class in order to call sendOtp function
//unused imports
//import 'package:flutter_otp/flutter_otp.dart';

import 'dart:math';

const _chars = '1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

String random = getRandomString(4);

class SendOtp extends StatelessWidget {
  final Telephony telephony = Telephony.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("send otp using flutter_otp ")),
      body: Container(
        child: Center(
            child: ElevatedButton(
              child: Text("Send"),
              onPressed: () {
                // call sentOtp function and pass the parameters
                telephony.sendSms(
                    to: "+1-555-521-5554",
                    message: "<# >"+random+" Verification Code from Skrrt, your Rent-a-Scooter App. Please don't reply to this message. Thank you and welcome to the family! SKRRT SKRRT!"
                );
              },
            )),
      ),
    );
  }
}