import 'package:flutter/material.dart';
//import 'package:skrrt_app/prj_stepper.dart' as v;
import 'home_page.dart';


class NewUser extends StatefulWidget {
  @override
  _NewUserState createState() => _NewUserState();
}
class _NewUserState extends State<NewUser> {
  int currentStep = 0;
  bool complete = false;

  void fieldFin(){
    complete = true;
    setState(() =>  currentStep+1);
  }

  next() {
    !complete
        ? goTo(currentStep+1)
        : fieldFin();
    if(currentStep+1 >=steps.length)
      complete = true;
  }

  goTo(int step) {
    complete = false;
    setState(() => currentStep = step);
  }

  cancel(){
    if(currentStep > 0){
      goTo(currentStep - 1);
    }
  }
  double uniHeight(BuildContext context){
    return MediaQuery.of(context).size.height*0.1;
  }
  double uniWidth(BuildContext context){
    return MediaQuery.of(context).size.width*0.1;
  }



  List<Step> get steps => [
    Step(
        isActive: currentStep>=0,
        state: currentStep >= 0 ? StepState.complete : StepState.disabled,
      title: const Text(''),
        content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  'Welcome to SKRRT!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: uniHeight(context)*0.30,

                    //fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                    color: Colors.white,
                  )
              ),
              SizedBox(
                height:  uniHeight(context)*0.15,
              ),
              Image(
                image: AssetImage("assets/newuser_nav.png"),
                height: uniHeight(context)+(uniHeight(context)/0.1*0.15),
                width: uniWidth(context)+(uniWidth(context)/0.1*0.9),
              ),
              SizedBox(
                height: uniHeight(context)*0.15,
              ),
              Text(
                  'Navigate to your destination easily!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: uniHeight(context)*0.25,

                    //fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                    color: Colors.white,
                  )
              ),
              SizedBox(
                height: 30,
              ),

            ],
        ),
    ),
    Step(
      isActive: currentStep>=1,
      state: currentStep >= 1 ? StepState.complete : StepState.disabled,
      title: const Text(''),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage("assets/skrrt-wallet-img_w.png"),
            height: uniHeight(context)+(uniHeight(context)/0.1*0.15),
            width: uniWidth(context)+(uniWidth(context)/0.1*0.9),
          ),
          SizedBox(
            height: uniHeight(context)*0.15,
          ),
          Text(
              'Pay easily using SKRRT Wallet!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: uniHeight(context)*0.25,
                //fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                color: Colors.white,
              )
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    ),
    Step(
      isActive: currentStep>=2,
      state: currentStep == 2 ? StepState.complete : StepState.disabled,
      title: const Text(''),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: uniHeight(context)*.15,
          ),
          Image(
            image: AssetImage("assets/useronscooter.png"),
            height: uniHeight(context)+(uniHeight(context)/0.1*0.15),
            width: uniWidth(context)+(uniWidth(context)/0.1*0.9),
          ),
          SizedBox(
            height: uniHeight(context)*.15,
          ),
          Text(
              'Rent a scooter and start your ride!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: uniHeight(context)*.25,

                //fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                color: Colors.white,
              )
          ),
          SizedBox(
            height: uniHeight(context)*.5
          ),

        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        backgroundColor: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
        body: Center(
            child: Padding(
              padding:EdgeInsets.symmetric(horizontal: uniWidth(context)*7/10),
                child: Theme(
                    data: ThemeData(
                        canvasColor: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
                        primaryColor: Colors.black,
                        backgroundColor: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
                        accentColor: Colors.white,
                        shadowColor: Colors.transparent,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: uniHeight(context)*0.5),
                        Image(
                          image: AssetImage("assets/skrrt_logo.png"),
                          height: uniHeight(context),
                          width: uniWidth(context)*2,
                        ),
                        SizedBox(
                        height: uniHeight(context)*0.5,
                        ),
                        Text(
                          'Your on-campus scooter on the go',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: uniHeight(context)*0.25,
                            //fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                            color: Colors.white,
                          )
                        ),
                        complete ? Expanded(
                          child: Stepper(
                              steps: steps,
                              type: StepperType.horizontal,
                              currentStep: currentStep,
                              onStepCancel: cancel,
                              onStepTapped: (step) => goTo(step),
                              controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) =>
                                  Container(
                                    child: RaisedButton(
                                        padding: EdgeInsets.all((uniHeight(context)*uniWidth(context))*.005),
                                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50.0)),
                                        textColor: Color(0xff00A8E5),
                                        color: Colors.white,
                                        child: Text(''
                                            'RIDE NOW',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color:Color(0xff00A8E5),
                                            fontSize: uniHeight(context)*0.25,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Home()),
                                          );
                                        }
                                    ),
                                  )
                          ),
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
                                      padding: EdgeInsets.all((uniHeight(context)*uniWidth(context))*.005),
                                      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50.0)),
                                      textColor: Color(0xff00A8E5),
                                      color: Colors.white,
                                      onPressed: next,
                                      child: Text(''
                                          'NEXT',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color:Color(0xff00A8E5),
                                          fontSize: uniHeight(context)*0.25,
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
      /*
      backgroundColor: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
        body: LayoutBuilder(
        builder: (context, constraints) {//still testing this portion, will change the
          if (constraints.maxWidth > 600) {
            return _buildWideContainers();
          } else {
            return _buildNormalContainer();
          }
        }

      ),*/
    );

  }
/*
  Widget _buildWideContainers() {
    return Center(
        child: Padding(
            padding:EdgeInsets.symmetric(horizontal: 10),
            child: Theme(
              data: ThemeData(
                canvasColor: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
                primaryColor: Colors.black,
                backgroundColor: Colors.white,
                accentColor: Colors.white,
                shadowColor: Colors.transparent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
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
                  complete ? Expanded(
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
                                  textColor: Color(0xff00A8E5),
                                  color: Colors.white,
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
                                      MaterialPageRoute(
                                          builder: (context) => Home()),
                                    );
                                  }
                              ),
                            )
                    ),
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
                                textColor: Color(0xff00A8E5),
                                color: Colors.white,
                                onPressed: next,
                                child: Text(''
                                    'NEXT',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color:Color(0xff00A8E5),
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
    );
  }
  Widget _buildNormalContainer() {
    return Center(
        child: Padding(
            padding:EdgeInsets.symmetric(horizontal: 10),
            child: Theme(
              data: ThemeData(
                canvasColor: Color.fromARGB(255, 0x00, 0xA8, 0xE5),
                primaryColor: Colors.black,
                backgroundColor: Colors.white,
                accentColor: Colors.white,
                shadowColor: Colors.transparent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
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
                  complete ? Expanded(
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
                                  textColor: Color(0xff00A8E5),
                                  color: Colors.white,
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
                                      MaterialPageRoute(
                                          builder: (context) => Home()),
                                    );
                                  }
                              ),
                            )
                    ),
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
                                textColor: Color(0xff00A8E5),
                                color: Colors.white,
                                onPressed: next,
                                child: Text(''
                                    'NEXT',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color:Color(0xff00A8E5),
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
    );
  }

*/
}