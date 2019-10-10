import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyProgress extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Progress Metet',
      home: progressPage(context),
    );
  }
}

Widget progressPage(BuildContext context) {
  int currentStep = 1;
  onStepContinue(){

  }
  onStepCancel(){

  }
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
      title: Text("Lesson 1: Exam"),),
    body: new Stepper(
      type: StepperType.horizontal,
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
      steps: const <Step>[
        Step(
          title: Text(''),
          content: SizedBox(
            width: 100,
            height: 100,
          ),
          state: StepState.complete,
          isActive: true,
        ),
        Step(
          title: Text(''),
          content: SizedBox(
            width: 100,
            height: 100,
          ),
          state: StepState.error,
          isActive: true,
        ),
        Step(
          title: Text(''),
          content: SizedBox(
            width: 100,
            height: 100,
          ),
          state: StepState.disabled,
        ),
        Step(
          title: Text(''),
          content: SizedBox(
            width: 100,
            height: 100,
          ),
          state: StepState.disabled,
        ),
        Step(
          title: Text(''),
          content: SizedBox(
            width: 100,
            height: 100,
          ),
          state: StepState.disabled,
        ),
      ],
    ),
  );
}
