import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heutagogy/tests/test3.dart';
import 'package:heutagogy/tests/test4.dart';
import 'package:heutagogy/tests/test5.dart';
import 'package:heutagogy/tests/test6.dart';

class MyProgressPage extends StatefulWidget {
  @override
  ProgressPageState createState() => ProgressPageState();
}

class ProgressPageState extends State<MyProgressPage> {
  int currentStep = 3;
  List<Step> _mySteps() {
    return [
      Step(
        title: Text(''),
        content: Text("Puzzle 1 will come here"),
        isActive: (currentStep >= 0),
        state: (currentStep == 0)
            ? StepState.editing
            : ((currentStep > 0) ? StepState.complete : StepState.indexed),
      ),
      Step(
        title: Text(''),
        content: Text("Puzzle 2 will come here"),
        isActive: (currentStep >= 1),
        state: (currentStep == 1)
            ? StepState.editing
            : ((currentStep > 1) ? StepState.complete : StepState.indexed),
      ),
      Step(
        title: Text(''),
        content: Test3Page(),
        isActive: (currentStep >= 2),
        state: (currentStep == 2)
            ? StepState.editing
            : ((currentStep > 2) ? StepState.complete : StepState.indexed),
      ),
      Step(
        title: Text(''),
        content: Test4Page(),
        isActive: (currentStep >= 3),
        state: (currentStep == 3)
            ? StepState.editing
            : ((currentStep > 3) ? StepState.complete : StepState.indexed),
      ),
      Step(
        title: Text(''),
        content: Test5Page(),
        isActive: (currentStep >= 4),
        state: (currentStep == 4)
            ? StepState.editing
            : ((currentStep > 4) ? StepState.complete : StepState.indexed),
      ),
      Step(
        title: Text(''),
        content: Test6Page(),
        isActive: (currentStep >= 5),
        state: (currentStep == 5)
            ? StepState.editing
            : ((currentStep > 5) ? StepState.complete : StepState.indexed),
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
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Lesson 1: Exam",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Theme(
        data: ThemeData(
          canvasColor: Colors.white,
        ),
        child: Stepper(
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: (showFab
          ? Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: FloatingActionButton.extended(
                      backgroundColor: Colors.white,
                      splashColor: Colors.lightBlueAccent,
                      heroTag: 'NextStep',
                      onPressed: () {
                        if (currentStep < _mySteps().length - 1) {
                          setState(() {
                            currentStep = currentStep + 1;
                          });
                        } else {
                          Navigator.popUntil(context,
                              ModalRoute.withName(Navigator.defaultRouteName));
                        }
                      },
                      label: Text(
                        "Next",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.circular(40)),
                      icon: Icon(
                        Icons.navigate_next,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      splashColor: Colors.lightBlueAccent,
                      heroTag: 'PreviousStep',
                      onPressed: () {
                        if (currentStep > 0) {
                          onStepCancel();
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      shape: CircleBorder(
                          side: BorderSide(color: Colors.blue, width: 1)),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : null),
    );
  }
}
