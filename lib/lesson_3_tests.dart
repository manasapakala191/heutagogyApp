import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heutagogy/data_models.dart';
import 'package:heutagogy/my_stepper.dart';
import 'package:heutagogy/tests/star_rating.dart';
import 'package:heutagogy/tests/test1.dart';
import 'package:heutagogy/tests/test2.dart';
import 'package:heutagogy/tests/test3.dart';
import 'package:heutagogy/tests/test4.dart';
import 'package:heutagogy/tests/test5.dart';
import 'package:heutagogy/tests/test10.dart';
import 'package:heutagogy/tests/test8.dart';
import 'package:heutagogy/well_done_page.dart';
import 'package:youtube_player/youtube_player.dart';

class MyLesson3Tests extends StatefulWidget {
  final LessonData lessonData;

  MyLesson3Tests(this.lessonData);

  @override
  Lesson1TestsState createState() => Lesson1TestsState(lessonData);
}

class Lesson1TestsState extends State<MyLesson3Tests> {
  List<Step> mySteps;
  int maxLength;

  Lesson1TestsState(LessonData lessonData) {
    this.lessonData = lessonData;
    this.mySteps = _buildSteps();
  }

  _buildSteps() {
    int i = 0;
    List<Step> mySteps = [];
    mySteps.add(Step(
      title: Text(''),
      content: Test10Page(),
      isActive: (i++) == this.currentStep,
      state: StepState.indexed,
    ));
    mySteps.add(Step(
      title: Text(''),
      content: Lesson3Videos(),
      isActive: (i++) == this.currentStep,
      state: StepState.indexed,
    ));
    mySteps.add(Step(
        title: Text(''),
        content: StarTest(
          "Put a bowl of water for birds everyday in your school and give yourself 3 stars.",
          key: ObjectKey(1),
        ),
        isActive: (i++) == this.currentStep));
    for (int z = 0; z < 10; z++) {
      if (lessonData.test1 != null && z < lessonData.test1.length) {
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
      if (lessonData.test2 != null && z < lessonData.test2.length) {
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
      if (lessonData.test3 != null && z < lessonData.test3.length) {
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
      if (lessonData.test4 != null && z < lessonData.test4.length) {
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

      if (lessonData.test6 != null && z < lessonData.test6.length) {
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

    mySteps.add(Step(
        title: Text(''),
        content: StarTest(
          "Does the air and water have weight? Prove it and give yourself 3 stars.",
          key: ObjectKey(2),
        ),
        isActive: (i++) == this.currentStep));
    mySteps.add(Step(
      title: Text(''),
      content:
          Test8Page([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000], [200, 300, 600, 800, 900]),
      isActive: (i++) == this.currentStep,
      state: StepState.indexed,
    ));
    mySteps.add(Step(
        title: Text(''),
        content: WellDonePage(),
        isActive: (i++) == this.currentStep,
        state: StepState.indexed));
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
        title: Text(
          "Lesson 3: Exam",
          style: TextStyle(color: Colors.black),
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
          steps: this.mySteps,
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
                        if (currentStep < maxLength - 1) {
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

class Lesson3Videos extends StatefulWidget {
  @override
  _Lesson3VideosState createState() => _Lesson3VideosState();
}

class _Lesson3VideosState extends State<Lesson3Videos> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            child: Text("chitti chitti miriyalu"),
            padding: EdgeInsets.only(top: 20),
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          YoutubePlayer(
            width: 360,
            context: context,
            source: "https://www.youtube.com/watch?v=1KwAhTF8cXg",
            quality: YoutubeQuality.HIGH,
            autoPlay: false,
            showVideoProgressbar: true,
            hideShareButton: true,
          ),
          Padding(
            child: Text("pottelu kanna talli gorre"),
            padding: EdgeInsets.only(top: 20),
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          YoutubePlayer(
            width: 360,
            context: context,
            source: "https://www.youtube.com/watch?v=6_PiAF4wEFQ",
            quality: YoutubeQuality.HIGH,
            autoPlay: false,
            showVideoProgressbar: true,
            hideShareButton: true,
          ),
          Padding(
            child: Text("my day songs and rhyme"),
            padding: EdgeInsets.only(top: 20),
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          YoutubePlayer(
            width: 360,
            context: context,
            source: "https://www.youtube.com/watch?v=H8atgJjtJUI",
            quality: YoutubeQuality.HIGH,
            autoPlay: false,
            showVideoProgressbar: true,
            hideShareButton: true,
          )
        ],
      ),
    );
  }
}
