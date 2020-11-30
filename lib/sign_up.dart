import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
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
   var url = "http://192.168.1.4/skrrt/register.php";  //localhost, change 192.168.1.9 to ur own localhost
   await http.post(url, body:{
           "fname": fname.text,
           "lname": lname.text,
           "idNo": idno.text,
           "status": status,
           "username": username.text,
           "password": pass.text,
           "phoneNo": phone.text,
           "birthday": dateCtl.text,
           "course": drop1value,
           "year": drop2value,
           "dept": "Computer Science",
         });
  }

  final _formKey = GlobalKey<FormState>();

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

  void toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIos: 1,
        fontSize: 16.0
    );
  }

  int selectedRadio;
  String course,year,status,drop1value,drop2value;
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
    selectedRadio = 1;
    pass.text ="";
    crse = ['CS', 'IT', 'ME', 'ECE'];
    colg = ['CCS', 'CEA', 'CMBA', 'CASE'];
    drop1 =  ['CS', 'IT', 'ME', 'ECE'];

    drop1value = null;
    drop2value = null;
    status = "student";
    yr = ['1', '2', '3', '4'];
    dept = ['IT', 'CS', 'ME', 'CE'];
    drop2 = ['1', '2', '3', '4'];
  }

  setSelectedRadio(int val){
    setState(() {
      selectedRadio = val;
      if(val == 1){
        radcolor1 = Color.fromARGB(255, 0x00, 0xA8, 0xE5);
        radcolor2 = Colors.black54;
        status = "student";
        drop1value = null;
        drop2value = null;
      }
      else{
        radcolor2 = Color.fromARGB(255, 0x00, 0xA8, 0xE5);
        radcolor1 = Colors.black54;
        status = "faculty";
        drop1value = null;
        drop2value = null;
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
    else{
      Navigator.pop(
        context,
      );
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
              height: MediaQuery.of(context).size.height * 0.5,
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
                    controller: fname,
                    cursorColor: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    validator: (value){
                      if(value.isEmpty){
                        return 'First Name is required.';
                      }
                      else if(!RegExp('[a-zA-Z]').hasMatch(value)){
                        return 'Invalid First Name.';
                      }
                      else return null;
                    },
                    onSaved: (name)=> fname.text = name,
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
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    validator: (value){
                      if(value.isEmpty){
                        return 'Last Name is required.';
                      }
                      else if(!RegExp('[a-zA-Z]').hasMatch(value)){
                        return 'Invalid Last Name.';
                      }
                      else return null;
                    },
                    onSaved: (name)=> lname.text = name,
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
                    textInputAction: TextInputAction.next,
                    validator: (value){
                      if(value.isEmpty){
                        return 'Phone No. is required.';
                      }
                      else if(!RegExp('[0][9][0-9]{9}').hasMatch(value)){
                        return 'Must begin with 09 first and must only be 11 digits.';
                      }
                      else return null;
                    },
                    onSaved: (value)=> phone.text = value,
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
                    textInputAction: TextInputAction.done,
                    validator: (value){
                      if(value.isEmpty){
                        return 'Birthday is required.';
                      }
                      else if(!RegExp('[0-9]{2}[\/][0-9]{2}[\/][0-9]{4}').hasMatch(value)){
                        return 'Must be MM/dd/yyyy in format (ex: 12/20/2020)';
                      }
                      else return null;
                    },
                    onSaved: (value)=> dateCtl.text = dateCtl.text,
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
                      dateCtl.text = DateFormat("MM/dd/yyyy").format(date).toString();
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
            height: MediaQuery.of(context).size.height * 0.5,
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
                      child: DropdownButtonFormField<String>(
                        validator: (String value) {
                          if (value?.isEmpty ?? true) {
                            return 'Required';
                          }
                          else return null;
                        },
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

                        /*underline: Container(
                          height: 1.1,
                          color: Colors.grey,
                        ),*/
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
                      child: DropdownButtonFormField<String>(
                        validator: (String value) {
                          if (value?.isEmpty ?? true) {
                            return 'Required';
                          }
                          else return null;
                        },
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
                        /*underline: Container(
                          height: 1.1,
                          color: Colors.grey,
                        ),*/
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
                  controller: idno,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'ID No. is Required.';
                    }
                    else if(!RegExp('[0-9]{2}[-][0-9]{4}[-][0-9]{3}').hasMatch(value)){
                      return 'Must be in correct format (ex: 12-2525-969)';
                    }
                    else return null;
                  },
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
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'ID picture is Required.';
                    }
                    else return null;
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
                    controller: username,
                    textInputAction: TextInputAction.next,
                    validator: (username){
                      Pattern pattern =
                          r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                      RegExp regex = new RegExp(pattern);
                      if (username.isEmpty) {
                        return 'Password is required.';
                      }
                      else if (!regex.hasMatch(username))
                        return 'Invalid Username.';
                      else
                        return null;
                    },
                    onSaved: (name)=> username.text = name,
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
                    textInputAction: TextInputAction.done,
                    validator: (password){
                      Pattern pattern =
                          r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                      RegExp regex = new RegExp(pattern);
                      if (password.isEmpty) {
                        return 'Password is required.';
                      }
                      else if (!regex.hasMatch(password))
                        return 'Must contain at least 1 letter and 1 number.\nMust be longer than six characters';
                      else
                        return null;
                    },
                    onSaved: (password)=> pass.text = password,
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
            data: ThemeData(
              canvasColor: Colors.white,
              shadowColor: Colors.transparent,
              primaryColor: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
              accentColor: Color.fromARGB(255, 0xE1, 0xDE, 0xDE),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                !complete ? SizedBox(height: MediaQuery.of(context).size.height * 0.04):SizedBox(height: 0),
                !complete ?Align(
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
                ):SizedBox(height: 0),
                !complete ? Image(
                  image: AssetImage("assets/skrrt_logo1.jpg"),
                  height: 100,
                  width: 100,
                ):SizedBox(height: 0),
                !complete ? SizedBox(height: MediaQuery.of(context).size.height * 0.04,):SizedBox(height: 0),
                !complete ? Text(
                    'SIGN UP',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                      color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
                    )
                ): SizedBox(height: 0),

                complete ? Expanded(
                    child: Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Image(
                              image: AssetImage("assets/user_check.png"),
                              height: 65,
                              width: 65,
                            ),
                            SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                            Text('Successful!',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 33.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                                color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
                              ),
                            ),
                            SizedBox(height: 2),
                            Text("Start your ride now!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                letterSpacing: 1.0,
                                fontSize: 20.0,),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.width * 0.07),
                            RaisedButton(
                              padding: EdgeInsets.symmetric(vertical:10.0,horizontal: 60.0),
                              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50.0)),
                              color: Color(0xff00A8E5),
                              disabledColor: Colors.grey,//add this to your code
                              child: Text('Start Now!',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color:Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              //child: new Text("Close"),
                              onPressed: () => Navigator.pop(context),
                            )]),
                    )
                ):
                Expanded(
                  child: Form(
                    key: _formKey,
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
                                    onPressed: (){
                                      if(_formKey.currentState.validate()){
                                        _formKey.currentState.save();
                                        //toastMessage("Username: $username\nPassword: $pass");
                                        next();
                                      }
                                    },
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
                  )
                ),
              ],),
          )
      ),
    );
  }
}