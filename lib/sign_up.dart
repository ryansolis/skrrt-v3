import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  int selectedRadio;
  String course;
  String year;

  @override
  void initState(){
    super.initState();
    selectedRadio = 0;
  }
  setSelectedRadio(int val){
    setState(() {
      selectedRadio = val;
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
            decoration: InputDecoration(
                hintText: 'First Name',
                hintStyle: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 16.0,
                color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
                )
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Last Name',
                hintStyle: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 16.0,
                  color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
                )
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Phone Number',
                hintStyle: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 16.0,
                  color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
                )
            ),
          ),
          TextFormField(
              decoration: InputDecoration(
                  hintText: 'Birthday',
                  hintStyle: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 16.0,
                  color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
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
              ButtonBar(
                alignment: MainAxisAlignment.center,
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
                        color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
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
                        color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
                      )
                  ),
                ],
              )
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
                        color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),) ),
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
                    height: 2,
                    color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
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
                        color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),) ),
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
                    height: 2,
                    color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
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
            decoration: InputDecoration(
                  hintText: 'ID Number',
                  hintStyle: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 16.0,
                  color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
                )
            ),
          ),
          TextFormField(
            textAlign: TextAlign.start,
            decoration:
            InputDecoration(
                  hintText: 'Picture of ID',
                  hintStyle: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 16.0,
                  color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
                ),
            suffixIcon:  IconButton(
                icon: Icon(Icons.camera_alt_rounded,
                  ),
                /*
                onPressed: () {
                  setState(() {
                    _volume += 10;
                  });
                },*/
              ),
            )
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
          ),
          SizedBox(height:10),
          TextFormField(
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
          ),
          SizedBox(height:30),
        ],
      ),

    ),
    Step(
      title: const Text(''),
      isActive: currentStep>=3,
      state: currentStep >= 3 ? StepState.complete : StepState.disabled,
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
         padding:EdgeInsets.symmetric(horizontal: 30),
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
                       title: Row(
                         children:[
                         Text('Sign up Successful!',
                           style: TextStyle(
                           fontFamily: 'Montserrat',
                           fontSize: 14.0,
                           fontWeight: FontWeight.bold,
                           letterSpacing: 1.0,
                           color: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
                         )
                     )],),
                     content: new Text("Start your ride now!",),
                     actions: <Widget>[
                       new FlatButton(
                         child: new Text("Close"),
                         onPressed: () => Navigator.pop(context),
                       )
                     ]
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