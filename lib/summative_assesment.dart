import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heutagogy/data_models.dart';
import 'package:heutagogy/assessment_tests/test1.dart';
import 'package:heutagogy/assessment_tests/test2.dart';
import 'package:heutagogy/assessment_tests/test3.dart';
import 'package:heutagogy/assessment_tests/test4.dart';
import 'package:heutagogy/assessment_tests/test7.dart';
import 'package:heutagogy/assessment_tests/test9.dart';

import 'dart:math';


class SummativeTests extends StatefulWidget {
  final LessonData lessonData;

  SummativeTests(this.lessonData);

  @override
  Lesson1TestsState createState() => Lesson1TestsState(lessonData);
}

class Lesson1TestsState extends State<SummativeTests> {
  List<Step> mySteps;

  Lesson1TestsState(LessonData lessonData) {
    this.mySteps = [];
    int i = 0;
    int maxLength = [
      lessonData.test1.length,
      lessonData.test2.length,
      lessonData.test3.length,
    ].reduce(max);
    for (int z = 0; z < maxLength; z++) {
      if (lessonData.test1 != null && z < lessonData.test1.length) {
        mySteps.add(Step(
          title: Text(''),
          content: Test1Page(
            lessonData.test1[z],
            key: UniqueKey(),
          ),
          isActive: true,
          state: StepState.indexed,
        ));
      }
      if (lessonData.test2 != null && z < lessonData.test2.length) {
        mySteps.add(Step(
          title: Text(''),
          content: Test2Page(
            lessonData.test2[z],
            key: ObjectKey(lessonData.test2[z]),
          ),
          isActive: true,
          state: StepState.indexed,
        ));
      }
      if (lessonData.test3 != null && z < lessonData.test3.length) {
        mySteps.add(Step(
          title: Text(''),
          content: Test3Page(
            lessonData.test3[z],
            key: UniqueKey(),
          ),
          isActive: true,
          state: StepState.indexed,
        ));
      }
      if (lessonData.test4 != null && z < lessonData.test4.length) {
        mySteps.add(Step(
          title: Text(''),
          content: Test4Page(
            lessonData.test4[z],
            key: UniqueKey(),
          ),
          isActive: true,
          state: StepState.indexed,
        ));
      }
      if (lessonData.test9 != null && z < lessonData.test9.length) {
        mySteps.add(Step(
          title: Text(''),
          content: Test9Page(
            lessonData.test9[z],
          ),
          isActive: true,
          state: StepState.indexed,
        ));
      }
    }

    mySteps.add(Step(
      title: Text(''),
      content: Test7Page(
          10,
          10,
          [2, 7, 12, 15, 19, 23, 27, 40, 41, 43, 45, 58, 62, 64, 66, 70, 73, 77, 81, 85, 93, 96, 99]
            ..shuffle()),
      isActive: true,
      state: StepState.indexed,
    ));

//    mySteps.add(Step(
//      title: Text(''),
//      content: Test5Page(),
//      isActive: true,
//      state: StepState.indexed,
//    ));
  }

  LessonData lessonData;
  int currentStep = 0;

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
        title: Hero(
          tag: "assessment",
          child: Material(
            color: Colors.transparent,
            child: Text(
              "Summative Assessments",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
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
          steps: mySteps,
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
                        if (currentStep < mySteps.length - 1) {
                          setState(() {
                            currentStep = currentStep + 1;
                          });
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      label: Text(
                        "Next",
                        style: TextStyle(
                            color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
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
                          setState(() {
                            currentStep = currentStep - 1;
                          });
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      shape: CircleBorder(side: BorderSide(color: Colors.blue, width: 1)),
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
