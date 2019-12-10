import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heutagogy/assessment_tests/test5.dart';
import 'package:heutagogy/data_models.dart';
import 'package:heutagogy/assessment_tests/test1.dart';
import 'package:heutagogy/assessment_tests/test2.dart';
import 'package:heutagogy/assessment_tests/test3.dart';
import 'package:heutagogy/assessment_tests/test4.dart';
import 'package:heutagogy/assessment_tests/test6.dart';
import 'package:heutagogy/assessment_tests/test7.dart';
import 'package:heutagogy/assessment_tests/test9.dart';
import 'package:heutagogy/assessment_tests/transition.dart';
import 'dart:math';

import 'package:heutagogy/my_stepper.dart';
import 'package:heutagogy/well_done_page.dart';

class SummativeTests extends StatefulWidget {
  final LessonData lessonData;

  SummativeTests(this.lessonData);

  @override
  Lesson1TestsState createState() => Lesson1TestsState(lessonData);
}

class Lesson1TestsState extends State<SummativeTests> {
  // List<Step> mySteps;
  // List<bool> myStepStates;
  int maxLength;

  Lesson1TestsState(LessonData lessonData) {
    this.maxLength = [
      lessonData.test1.length,
      lessonData.test2.length,
      lessonData.test3.length,
      lessonData.test4.length,
      lessonData.test6.length,
    ].reduce(max);
    this.lessonData = lessonData;
  }

  _buildSteps() {
    List<Step> mySteps = [];
    int i = 0;
    List<String> subjects = [
      "english",
      "maths",
      "evs",
      "telugu",
    ];

    for (String sub in subjects) {
      mySteps.add(
        Step(
          content: TransitionPage(subject: sub),
          isActive: (i++) == this.currentStep,
          title: Text(sub.toUpperCase()),
          state: StepState.indexed,
        ),
      );

      if (sub == "maths") {
        mySteps.add(Step(
          title: Text(''),
          content: Test7Page(
              10,
              10,
              [
                2,
                7,
                12,
                15,
                19,
                23,
                27,
                40,
                41,
                43,
                45,
                58,
                62,
                64,
                66,
                70,
                73,
                77,
                81,
                85,
                93,
                96,
                99
              ]..shuffle()),
          isActive: (i++) == this.currentStep,
          state: StepState.indexed,
        ));
      }
      if (sub == "evs") {
        mySteps.add(Step(
          title: Text(''),
          content: Test6Page(),
          isActive: (i++) == this.currentStep,
          state: StepState.indexed,
        ));
      }
      if (sub == "telugu") {
        mySteps.add(Step(
            title: Text(''),
            content: HardCoded("వినడం, ఆలోచించి మాట్లాడటం, ప్రశంస:",
                "గువ్వకు జొరమమ్మ గేయం వినండి, మీకు ఆ గేయంలో నచ్చిన పదాలు చెప్పండి."),
            isActive: (i++) == this.currentStep));
        mySteps.add(Step(
            title: Text(''),
            content: HardCoded("చదవడం:\n క్రింది పదాలు చదవండి",
                "ముద్ద\nఅమ్మ \nబల్లి \nఅక్క \nమువ్వ \nబొజ్జ \nచద్ది \nబొమ్మ \nకొమ్మ \nమల్లి \nపిల్లి \nఅవ్వ \nగువ్వ\nసజ్జ \nలెక్క"),
            isActive: (i++) == this.currentStep));
        mySteps.add(Step(
            title: Text(''),
            content: HardCoded("ఈ వాక్యాలను మీ పుస్తకంలో గుండ్రంగా రాయండి:",
                "అమ్మ అంటే నాకు మక్కువ\nఅక్క మొక్క నాటింది\nఅయ్య కొయ్య తెచ్చాడు"),
            isActive: (i++) == this.currentStep));
      }
      for (int z = 0; z < maxLength; z++) {
        if (lessonData.test1 != null && z < lessonData.test1.length) {
          if (lessonData.test1[z].subject == sub) {
            mySteps.add(Step(
              title: Text(''),
              content: Test1Page(
                lessonData.test1[z],
                key: UniqueKey(),
              ),
              isActive: (i++) == this.currentStep,
              state: StepState.indexed,
            ));
          }
        }
        if (lessonData.test2 != null && z < lessonData.test2.length) {
          if (lessonData.test2[z].subject == sub) {
            mySteps.add(Step(
              title: Text(''),
              content: Test2Page(
                lessonData.test2[z],
                key: ObjectKey(lessonData.test2[z]),
              ),
              isActive: (i++) == this.currentStep,
              state: StepState.indexed,
            ));
          }
        }
        if (lessonData.test3 != null && z < lessonData.test3.length) {
          if (lessonData.test3[z].subject == sub) {
            mySteps.add(Step(
              title: Text(''),
              content: Test3Page(
                lessonData.test3[z],
                key: UniqueKey(),
              ),
              isActive: (i++) == this.currentStep,
              state: StepState.indexed,
            ));
          }
        }
        if (lessonData.test4 != null && z < lessonData.test4.length) {
          if (lessonData.test4[z].subject == sub) {
            mySteps.add(Step(
              title: Text(''),
              content: Test4Page(
                lessonData.test4[z],
                key: UniqueKey(),
              ),
              isActive: (i++) == this.currentStep,
              state: StepState.indexed,
            ));
          }
        }
        if (lessonData.test6 != null && z < lessonData.test6.length) {
          if (lessonData.test6[z].subject == sub) {
            mySteps.add(Step(
              title: Text(''),
              content: Test5Page(
                lessonData.test6[z],
                key: UniqueKey(),
              ),
              isActive: (i++) == this.currentStep,
              state: StepState.indexed,
            ));
          }
        }
        if (lessonData.test9 != null && z < lessonData.test9.length) {
          if (lessonData.test9[z].subject == sub) {
            mySteps.add(Step(
              title: Text(''),
              content: Test9Page(
                lessonData.test9[z],
              ),
              isActive: (i++) == this.currentStep,
              state: StepState.indexed,
            ));
          }
        }
      }
    }

    mySteps.add(
      Step(
          title: Text(''),
          content: WellDonePage(),
          isActive: (i++) == this.currentStep,
          state: StepState.indexed),
    );
    this.maxLength = i;
    return mySteps;
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
        child: MyStepper(
          type: MyStepperType.horizontal,
          currentMyStep: this.currentStep,
          onMyStepTapped: onStepTapped,
          steps: _buildSteps(),
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
                      backgroundColor: (currentStep == maxLength - 1)
                          ? Colors.blueAccent
                          : Colors.white,
                      splashColor: (currentStep == maxLength - 1)
                          ? Colors.white54
                          : Colors.lightBlueAccent,
                      heroTag: 'NextStep',
                      onPressed: () {
                        if (currentStep < maxLength - 1) {
                          setState(() {
                            currentStep = currentStep + 1;
                          });
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      label: Text(
                        (currentStep == maxLength - 1) ? "Finish" : "Next",
                        style: TextStyle(
                            color: (currentStep == maxLength - 1)
                                ? Colors.white
                                : Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.circular(40)),
                      icon: (currentStep == maxLength - 1)
                          ? null
                          : Icon(
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

class HardCoded extends StatelessWidget {
  final String text, text2;
  const HardCoded(this.text, this.text2, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 10),
            child: Text(text,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Text(text2, style: TextStyle(fontSize: 20)),
          )
        ],
      )),
    );
  }
}
