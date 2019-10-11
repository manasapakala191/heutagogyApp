import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyProgress extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Progress Meter',
      home: ProgressPage(),
    );
  }
}

class ProgressPage extends StatefulWidget {
  @override
  ProgressPageState createState() => ProgressPageState();
}

class ProgressPageState extends State<ProgressPage> {
  int currentStep = 1;
  List<Step> _mySteps = [
    Step(
      title: Text(''),
      content: SizedBox(
        child: Text("Hello"),
        width: 100,
        height: 100,
      ),
    ),
    Step(
      title: Text(''),
      content: SizedBox(
        child: Text("How"),
        width: 100,
        height: 100,
      ),
    ),
    Step(
      title: Text(''),
      content: SizedBox(
        child: Text("Are"),
        width: 100,
        height: 100,
      ),
    ),
    Step(
      title: Text(''),
      content: SizedBox(
        child: Text("You"),
        width: 100,
        height: 100,
      ),
    ),
    Step(
      title: Text(''),
      content: SizedBox(
        child: Text("?"),
        width: 100,
        height: 100,
      ),
    ),
  ];

  onStepContinue() {
    setState(() {
      if (currentStep < _mySteps.length - 1) {
        currentStep = currentStep + 1;
      } else {
        currentStep = 0;
      }
    });
    print("On Step Continue: " + currentStep.toString());
  }

  onStepCancel() {
    setState(() {
      if (currentStep > 0) {
        currentStep = currentStep - 1;
      } else {
        currentStep = 0;
      }
    });
    print("On Step Cancel: " + currentStep.toString());
  }

  onStepTapped(step) {
    setState(() {
      currentStep = step;
    });
    print("On Step Tapped: " + step.toString());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Lesson 1: Exam"),
      ),
      body: new Stepper(
        type: StepperType.horizontal,
        currentStep: this.currentStep,
        onStepTapped: onStepTapped,
        controlsBuilder: (BuildContext context,
            {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
          return Column(
            children: <Widget>[
              FlatButton(
                onPressed: onStepContinue,
                child: Text("Continue"),
              ),
              FlatButton(
                onPressed: onStepCancel,
                child: Text("Cancel"),
              ),
            ],
          );
        },
        steps: _mySteps,
      ),
      floatingActionButton: FloatingActionButton(
        child: IconButton(
          icon: Icon(Icons.navigate_next),
          onPressed: onStepContinue,
        ),
      ),
    );
  }
}
