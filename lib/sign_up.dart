import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:skrrt_app/sign_in.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController dateCtl = TextEditingController();
  TextEditingController cam = TextEditingController();
  TextEditingController pass = TextEditingController();
  PickedFile imageFile;


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
  String fname,lname,username,password, drop1value,drop2value;
  DateTime bday;
  Color radcolor1 = Colors.black54;
  Color radcolor2 = Colors.black54;
  List<String> crse;
  List<String> colg;
  List<String> drop1;

  List<String> yr;
  List<String> dept;
  List<String> drop2;

  @override
  void initState(){
    super.initState();
    crse = ['CS', 'IT', 'ME', 'ECE'];
    colg = ['CCS', 'CEA', 'CMBA', 'CASE'];
    drop1 =  ['CS', 'IT', 'ME', 'ECE'];

    drop1value = null;
    drop2value = null;

    yr = ['1', '2', '3', '4'];
    dept = ['IT', 'CS', 'ME', 'CE'];
    drop2 = ['1', '2', '3', '4'];
    selectedRadio = 0;
    pass.text ="";
  }

  setSelectedRadio(int val){
    setState(() {
      selectedRadio = val;
      if(val == 1){
        radcolor1 = Color.fromARGB(255, 0x00, 0xA8, 0xE5);
        radcolor2 = Colors.black54;
        drop1value = null;
        drop2value = null;
        drop1 = crse;
        drop2 = yr;
      }
      else{
        radcolor2 = Color.fromARGB(255, 0x00, 0xA8, 0xE5);
        radcolor1 = Colors.black54;
        drop1value = null;
        drop2value = null;
        drop1 = colg;
        drop2 = dept;
      }
    });
  }

  int currentStep = 0;
  bool complete = false;

  void fieldFin(){
    complete = true;
    setState(() =>  currentStep += 1);
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
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.07),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.41,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Personal Details',
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
              TextFormField(
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
            ],
          ),
        )
      )
    ),
    Step(
      isActive: currentStep>=1,
      state: currentStep >= 1 ? StepState.complete : StepState.disabled,
      title: const Text(''),
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.07),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.41,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'User Details',
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
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
                      hint: Text(
                          selectedRadio == 1 ? 'Course':'College',
                          style:TextStyle(
                            fontSize: 16,
                            fontFamily: 'Quicksand',
                          ) ),
                      isExpanded: true,
                      value: drop1value,
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
                          drop1value = newValue;
                        });
                      },
                      items: drop1
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
                      hint: Text(
                          selectedRadio == 1 ? 'Year':'Department',
                          style:TextStyle(
                            fontSize: 16,
                            fontFamily: 'Quicksand',
                          ) ),
                      isExpanded: true,
                      value: drop2value,
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
                          drop2value = newValue;
                        });
                      },
                      items: drop2
                          .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: dateCtl,
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
            ],
          ),
        ),

      )
    ),
    Step(
      isActive: currentStep>=2,
      state: currentStep >= 2 ? StepState.complete : StepState.disabled,
      title: const Text(''),
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.07),
        child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.30,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Account Details',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                  ),
                ),
                SizedBox( height:MediaQuery.of(context).size.height * 0.01),
                TextFormField(
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
              ],
            ),
        )
      )
    ),
    Step(
      title: const Text(''),
      isActive: currentStep>=3,
      state: currentStep == 3 ? StepState.complete : StepState.disabled,
      content: Padding(
          padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.07),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.41,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Verify Phone',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
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
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Verification Code',
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
              ],
            ),
        )
      )
    ),
  ];

  @override
  Widget build(BuildContext context) {
   return new Scaffold(
     backgroundColor: Colors.white,
     body: Container(
       child: Theme(
           data: ThemeData(  canvasColor: Colors.white, shadowColor: Colors.transparent ),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               SizedBox(height: MediaQuery.of(context).size.height * 0.04),
               Align(
                 alignment: Alignment.topLeft,
                 child: Padding(
                   padding: EdgeInsets.only(left: 10),
                   child:  IconButton(
                     icon: Icon(Icons.arrow_back_ios_rounded,
                       size: 20,
                     ),
                     onPressed: () {
                        Navigator.pop(
                        context,
                        );
                     }
                   )
                 )
               ),
               Image(
                 image: AssetImage("assets/skrrt_logo1.jpg"),
                 height: 100,
                 width: 100,
               ),
               SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
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
                             onPressed: () => Navigator.pop(context),
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
                     controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}){
                       return Padding(
                         padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.07),
                         child: Row(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Container(
                               width: MediaQuery.of(context).size.width * 0.35,
                               child: RaisedButton(
                                 padding: EdgeInsets.all(12.0),
                                 shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50.0)),
                                 textColor: Colors.white,
                                 color: Colors.grey,
                                 onPressed: cancel,
                                 child: Text(''
                                     'BACK',
                                   style: TextStyle(
                                     fontFamily: 'Montserrat',
                                     color:Colors.white,
                                     fontSize: 16,
                                   ),
                                 ),
                               ),
                             ),
                             Container(
                               width: MediaQuery.of(context).size.width * 0.35,
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
                           ],
                         )
                       );
                     },
                 ),
               ),
             ],),
       )
     ),
   );
  }
}