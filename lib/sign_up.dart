import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController idno = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController dateCtl = TextEditingController();
  TextEditingController cam = TextEditingController();
  TextEditingController pass = TextEditingController();
  PickedFile imageFile;

 Future registerData() async {
   var url = "http://192.168.1.11/skrrt/register.php";  //localhost, change 192.168.1.9 to ur own localhost
   await http.post(url, body:{
           "fname": fname.text,
           "lname": lname.text,
           "idNo": idno.text,
           "status": status,
           "username": username.text,
           "password": pass.text,
           "phoneNo": phone.text,
           "birthday": dateCtl.text,
           "course": course,
           "year": year,
           "dept": "Computer Science",
         });
  }


  _openGallery (BuildContext context) async {
    // ignore: deprecated_member_use
    var picture = await ImagePicker().getImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
      if(imageFile != null)
        cam.text = "Done";
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async{
    var picture = await ImagePicker().getImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
      if(imageFile != null)
        cam.text = "Done";
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialaog(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Choose"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text("Gallery"),
                onTap: (){
                  _openGallery(context);
                }
              ),
              SizedBox(height: 15,),
              GestureDetector(
                child: Text("Camera"),
                onTap: (){
                _openCamera(context);
                }
              )
            ],
          )
        )
      );
    });
  }

  int selectedRadio;
  String course,year,status;
  DateTime bday;
  Color radcolor1 = Colors.black54;
  Color radcolor2 = Colors.black54;

  @override
  void initState(){
    super.initState();
    selectedRadio = 0;
    pass.text ="";
  }

  setSelectedRadio(int val){
    setState(() {
      selectedRadio = val;
      if(val == 1){
        radcolor1 = Color.fromARGB(255, 0x00, 0xA8, 0xE5);
        radcolor2 = Colors.black54;
        status = "student";
      }
      else{
        radcolor2 = Color.fromARGB(255, 0x00, 0xA8, 0xE5);
        radcolor1 = Colors.black54;
        status = "faculty";
      }
    });
  }

  int currentStep = 0;
  bool complete = false;

  void fieldFin(){
    complete = true;
    setState(() =>  currentStep += 1);
    registerData();
  }
  next() {
    currentStep + 1 != steps.length
        ? goTo(currentStep + 1)
        : fieldFin();
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }

  cancel(){
    if(currentStep > 0){
      goTo(currentStep - 1);
    }
  }

  List<Step> get steps => [
    Step(
      title: const Text(''),
      isActive: currentStep>=0,
      state: currentStep >= 0 ? StepState.complete : StepState.disabled,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[
          Text(
            'Personal Details',
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 18.0,
              letterSpacing: 1.0,
            ),
          ),
          SizedBox(height:20),
          TextFormField(
            controller: fname,
            cursorColor: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
            decoration: InputDecoration(
                  hintText: 'First Name',
                  hintStyle: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 16.0,
                )
            ),
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 16.0,
              color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),),
          ),
          TextFormField(
            controller: lname,
            decoration: InputDecoration(
                hintText: 'Last Name',
                hintStyle: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 16.0,
                )
            ),
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 16.0,
              color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),),
          ),
          TextFormField(
            controller: phone,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: 'Phone Number',
                hintStyle: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 16.0,
                )
            ),
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 16.0,
              color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),),
          ),
          TextFormField(
              controller: dateCtl,
              decoration: InputDecoration(
                  hintText: 'Birthday',
                  hintStyle: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 16.0,
                ),
              suffixIcon:  IconButton(
                icon: Icon(Icons.calendar_today_rounded),
                iconSize: 20,
              ),
                /*
                onPressed: () {
                  setState(() {
                    _volume += 10;
                  });
                },*/
              ),
              onTap: () async{
              DateTime date = DateTime(1900);
              FocusScope.of(context).requestFocus(new FocusNode());

              date = await showDatePicker(
                  context: context,
                  initialDate:DateTime.now(),
                  firstDate:DateTime(1900),
                  lastDate: DateTime(2100));
              dateCtl.text = DateFormat("dd/MM/yyyy").format(date).toString();
              },
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 16.0,
              color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),),
            ),
          SizedBox(height:30),
        ],
      ),
    ),
    Step(
      isActive: currentStep>=1,
      state: currentStep >= 1 ? StepState.complete : StepState.disabled,
      title: const Text(''),
      content: Column(
        children: <Widget>[
          Text(
            'User Details',
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 18.0,
              letterSpacing: 1.0,
            ),
          ),
          SizedBox(height:20),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(
                  'Are you',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 16.0,
                    color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
                  )
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
                  Radio(
                    value:1,
                    groupValue: selectedRadio,
                    activeColor: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
                    onChanged: (val){
                      setSelectedRadio(val);
                    },
                  ),
                  Text(
                      'Student',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 16.0,
                        color: radcolor1,
                      )
                  ),
                  Radio(
                    value:2,
                    groupValue: selectedRadio,
                    activeColor: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
                    onChanged: (val){
                      setSelectedRadio(val);
                    },
                  ),
                  Text(
                      'Faculty',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 16.0,
                        color: radcolor2,
                      )
                  ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: DropdownButton<String>(
                  hint: Text('Course',
                      style:TextStyle(
                        fontSize: 16,
                        fontFamily: 'Quicksand',
                        ) ),
                  isExpanded: true,
                  value: course,
                  icon: Icon(Icons.arrow_drop_down_rounded, color: Colors.grey,),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Quicksand',
                    color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
                  ),
                  underline: Container(
                    height: 1.1,
                    color: Colors.grey,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      course = newValue;
                    });
                  },
                  items: <String>['BSCS', 'BSIT', 'BSCE', 'BSED']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  })
                      .toList(),
                ),
              ),
              SizedBox(width:10),
              Expanded(
                child: DropdownButton<String>(
                  hint: Text('Year',
                      style:TextStyle(
                        fontSize: 16,
                        fontFamily: 'Quicksand',
                        ) ),
                  isExpanded: true,
                  value: year,
                  icon: Icon(Icons.arrow_drop_down_rounded, color: Colors.grey),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Quicksand',
                    color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
                  ),
                  underline: Container(
                    height: 1.1,
                    color: Colors.grey,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      year = newValue;
                    });
                  },
                  items: <String>['1', '2', '3', '4']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  })
                      .toList(),
                ),
              )
            ],
          ),
          TextFormField(
            controller: idno,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                  hintText: 'ID Number',
                  hintStyle: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 16.0,
                )
            ),
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 16.0,
              color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),),
          ),
          TextFormField(
            onTap: () async{
              _showChoiceDialaog(context);
            },
            readOnly: true,
            controller: cam,
            textAlign: TextAlign.start,
            decoration:
            InputDecoration(
                  hintText: 'Picture of ID',
                  hintStyle: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 16.0,
                ),
            suffixIcon:  IconButton(
                icon: Icon(Icons.camera_alt_rounded,
                  ),
              ),
            ),
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 16.0,
              color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),),
          ),
          SizedBox(height:30),
        ],
      ),
    ),
    Step(
      isActive: currentStep>=2,
      state: currentStep >= 2 ? StepState.complete : StepState.disabled,
      title: const Text(''),
      content: Column(
        children: <Widget>[
          Text(
            'Account Details',
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 18.0,
              letterSpacing: 1.0,
            ),
          ),
          SizedBox(height:20),
          TextFormField(
            controller: username,
            autofocus: true,
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
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 16.0,
              color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),),
          ),
          SizedBox(height:10),
          TextFormField(
            controller: pass,
            obscureText: true,
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
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 16.0,
              color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),),
          ),
          SizedBox(height:30),
        ],
      ),

    ),
    Step(
      title: const Text(''),
      isActive: currentStep>=3,
      state: currentStep == 3 ? StepState.complete : StepState.disabled,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[
          Text(
            'Verify Phone',
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 18.0,
              letterSpacing: 1.0,
            ),
          ),
          SizedBox(height:20),
          Text(
            'Code is sent to',
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 16.0,
              letterSpacing: 1.0,
            ),
          ),
                      //Vince started here
          Text(
            '+63 936 396 7814',     //current dummy text for phone number
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 16.0,
              letterSpacing: 1.0,
            ),
          ),
          SizedBox(height:20),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Verification Code',
                hintStyle: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 16.0,
                  color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
                )
            ),
          ),
          SizedBox(height:30),
          Text(
            'Didn’t receive a code?',
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 16.0,
              letterSpacing: 1.0,
            ),
          ),
          Text(
            'Request again',
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 16.0,
              letterSpacing: 1.0,
              color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
            ),
          ),
          Text(
            'Get via Call',
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 16.0,
              letterSpacing: 1.0,
              color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
            ),
          ),
          SizedBox(height:40),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
   return new Scaffold(
     backgroundColor: Colors.white,
     body: Center(
       child: Padding(
         padding:EdgeInsets.symmetric(horizontal: 40),
         child: Theme(
           data: ThemeData(  canvasColor: Colors.white, shadowColor: Colors.transparent ),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               SizedBox(height: 50),
               Image(
                 image: currentStep!=3 ? AssetImage("assets/skrrt_logo1.jpg") : AssetImage("assets/mblverif.png"),
                 height: 100,
                 width: 100,
               ),
               SizedBox(height: 30),
               Text(
                   'SIGN UP',
                   style: TextStyle(
                     fontFamily: 'Montserrat',
                     fontSize: 25.0,
                     fontWeight: FontWeight.bold,
                     letterSpacing: 1.0,
                     color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
                   )
               ),

               complete ? Expanded(
                 child: Center(
                   child: AlertDialog(
                       title: Column(
                         children:[
                           Image(
                             image: AssetImage("assets/user_check.png"),
                             height: 100,
                             width: 100,
                           ),
                         Text('Successful!',

                           style: TextStyle(

                           fontFamily: 'Montserrat',
                           fontSize: 25.0,
                           fontWeight: FontWeight.bold,
                           letterSpacing: 1.0,
                           color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
                           ),
                       ),
                           //SizedBox(height: 30),
                           Text("Start your ride now!",
                             textAlign: TextAlign.center,
                               style: TextStyle(
                                 fontFamily: 'Montserrat',
                                 fontSize: 15.0,),
                           ),
                           SizedBox(height: 15),
                           RaisedButton(
                             padding: EdgeInsets.symmetric(vertical:15.0,horizontal: 24.0),
                             shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50.0)),
                             color: Color(0xff00A8E5),
                             disabledColor: Colors.grey,//add this to your code
                             child: Text('Start Now!',
                               style: TextStyle(
                                 fontFamily: 'Montserrat',
                                 color:Colors.white,
                                 fontSize: 16,
                               ),
                             ),
                             //child: new Text("Close"),
                             onPressed: () {
                               Navigator.pop(context);
                             }
                           )
/*                        */]),
/*
                     actions: <Widget>[
                       new
                     ]*/
                   )
                 )
                ):
                    Expanded(
                 child: Stepper(
                     steps: steps,
                     type: StepperType.horizontal,
                     currentStep: currentStep,
                     onStepCancel: cancel,
                     onStepTapped: (step) => goTo(step),
                     controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) =>
                         Container(
                           child: RaisedButton(
                             padding: EdgeInsets.all(12.0),
                             shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50.0)),
                             textColor: Colors.white,
                             color: Color(0xff00A8E5),
                             onPressed: next,
                             child: Text(''
                                 'NEXT',
                               style: TextStyle(
                                 fontFamily: 'Montserrat',
                                 color:Colors.white,
                                 fontSize: 16,
                               ),
                             ),
                           ),
                         )
                 ),
               ),
             ],),
         )
       )
     ),
   );
  }
}