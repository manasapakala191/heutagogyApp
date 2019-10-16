import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heutagogy/lessons.dart';
import 'package:heutagogy/test_page_3.dart';

class MyProgressPage extends StatefulWidget {
  @override
  ProgressPageState createState() => ProgressPageState();
}

class ProgressPageState extends State<MyProgressPage> {
  int currentStep = 0;

  List<Step> _mySteps() {
    return [
      Step(
        title: Text(''),
        content: TestPage3(),
        isActive: (currentStep >= 0),
        state: (currentStep == 0) ? StepState.editing : ((currentStep > 0) ? StepState.complete : StepState.indexed),
      ),
      Step(
        title: Text(''),
        content: Text("Puzzle 2 will come here"),
        isActive: (currentStep >= 1),
        state: (currentStep == 1) ? StepState.editing : ((currentStep > 1) ? StepState.complete : StepState.indexed),
      ),
      Step(
        title: Text(''),
        content: Text("Puzzle 3 will come here"),
        isActive: (currentStep >= 2),
        state: (currentStep == 2) ? StepState.editing : ((currentStep > 2) ? StepState.complete : StepState.indexed),
      ),
      Step(
        title: Text(''),
        content: Text("Puzzle 4 will come here"),
        isActive: (currentStep >= 3),
        state: (currentStep == 3) ? StepState.editing : ((currentStep > 3) ? StepState.complete : StepState.indexed),
      ),
      Step(
        title: Text(''),
        content: Text("Puzzle 5 will come here"),
        isActive: (currentStep >= 4),
        state: (currentStep == 4) ? StepState.editing : ((currentStep > 4) ? StepState.complete : StepState.indexed),
      ),
      Step(
        title: Text(''),
        content: Text("Puzzle 6 will come here"),
        isActive: (currentStep >= 5),
        state: (currentStep == 5) ? StepState.editing : ((currentStep > 5) ? StepState.complete : StepState.indexed),
      ),
    ];
  }

  onStepContinue() {
    setState(() {
      if (currentStep < _mySteps().length - 1) {
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
        steps: _mySteps(),
        controlsBuilder: (BuildContext context,
            {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
          return Row(
            children: <Widget>[
              Container(
                child: null,
              ),
              Container(
                child: null,
              ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: FloatingActionButton(
                heroTag: 'NextStep',
                onPressed: () {
                  if (currentStep < _mySteps().length - 1){
                    setState(() {
                      currentStep = currentStep + 1;
                    });
                  }
                  else{
                    Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                  }
                },
                child: Icon(Icons.navigate_next),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: FloatingActionButton(
                heroTag: 'PreviousStep',
                onPressed: onStepCancel,
                child: Icon(Icons.navigate_before),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
