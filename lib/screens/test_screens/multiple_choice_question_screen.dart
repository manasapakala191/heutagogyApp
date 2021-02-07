import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/progress.dart';
import 'package:heutagogy/models/studentProgress.dart';
import 'package:heutagogy/models/test_type_models/multiple_choice_question_test.dart';
import 'package:heutagogy/models/test_type_models/option_class.dart';
import 'package:heutagogy/models/test_type_models/question_class.dart';
import 'package:heutagogy/models/userModel.dart';
import 'package:heutagogy/screens/handyWidgets/customAppBar.dart';
import 'package:heutagogy/screens/handyWidgets/slideHeading.dart';
import 'package:heutagogy/screens/score_screens/single_correct_test_result_viewer.dart';
import 'package:heutagogy/services/database.dart';
import 'package:provider/provider.dart';
import 'package:heutagogy/models/time_object_model.dart';

class MultipleChoiceQuestionScreen extends StatefulWidget {
  final singleCorrectTest;
  final String courseID, lessonID, type;
  MultipleChoiceQuestionScreen(
      {this.singleCorrectTest, this.type, this.courseID, this.lessonID});

  @override
  _MultipleChoiceQuestionScreenState createState() =>
      _MultipleChoiceQuestionScreenState(this.singleCorrectTest);
}

class _MultipleChoiceQuestionScreenState
    extends State<MultipleChoiceQuestionScreen> {
  final SingleCorrectTest singleCorrectTest;
  _MultipleChoiceQuestionScreenState(this.singleCorrectTest);

  var answers = Map<String, dynamic>();
  var choices = Map<String, dynamic>();

  int count = 0;

  int total = 0;

  List<String> responses = List<String>();

  Map<String, dynamic> getResponseMap() {
    Map<String, dynamic> responseMap = Map<String, dynamic>();
    print("debug" + responses.toString());
    for (int i = 0; i < singleCorrectTest.questions.length; i++) {
      responseMap[singleCorrectTest.questions[i].text] = responses[i];
    }
    print(responseMap);
    return responseMap;
  }

  void _updateProgress() {
    var user = Provider.of<UserModel>(context, listen: false);
    String studentID = user.getID();
    for (var _ in choices.values) {
      responses.add(_);
    }
    print(responses);
    int count = 0, total = 0;
    for (var _ in answers.values) {
      if (_) {
        count++;
      }
      total++;
    }
    var progress = Progress(name: singleCorrectTest.testName,
        description: singleCorrectTest.testDescription,
        partsDone: count,
        total: total,
        responses: responses);
    Map<String, dynamic> json = progress.toMap();
    print(json.toString() + "mcq text progress");
    DatabaseService().writeProgress(
        json, studentID, widget.courseID, widget.lessonID, widget.type);
  }

  final TimeObject timeObject = TimeObject(
      screen: 'Multiple Choice Questions Screen',
      courseId: 'Default Course ID',
      testId: 'Default Test ID');

  @override
  void initState() {
    for (var _ in singleCorrectTest.questions) {
      answers[_.text] = false;
      choices[_.text] = null;
    }
    timeObject.setStartTime(DateTime.now());
    super.initState();
  }

  @override
  void dispose() {
    timeObject.setEndTime(DateTime.now());
    timeObject.addTimeObjectToStudentPerformance();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeObject.getStudent(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: singleCorrectTest.subject,
      ),
      backgroundColor: HexColor('#f7f7f7'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SlideHeader(testName: singleCorrectTest.testName,testDescription: singleCorrectTest.testDescription,),
            Column(
                children: singleCorrectTest.questions
                    .map<Widget>(
                        (e) => QuestionWidget(e, this.answers, this.choices))
                    .toList()),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              minWidth: 75,
              height: 65,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text("Submit",style: TextStyle(color: Colors.white),),
              color: Colors.redAccent,
              // Colors.white,
              // HexColor("#ed2a26"),
              padding: const EdgeInsets.all(5),
              onPressed: () {
                _updateProgress();
                 showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Quiz submitted!"),
                        content: Text("The Quiz is submitted successfully"),
                        actions: [
                          FlatButton(
                            child: Text("Stay"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          FlatButton(
                            child: Text("Leave"),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}

class QuestionWidget extends StatelessWidget {
  final QuestionData question;
  final Map answers, choices;
  QuestionWidget(this.question, this.answers, this.choices);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.grey[200], blurRadius: 3)]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(7),
            child: Text(question.text, style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600
            ),),
          ),
          Divider(
            color: HexColor("#607196"),
          ),
          OptionBuilder(
              question.options, this.answers, this.choices, question.text)
        ],
      ),
    );
  }
}

class OptionBuilder extends StatefulWidget {
  final List<Option> options;
  final Map answers, choices;
  final String question;
  OptionBuilder(this.options, this.answers, this.choices, this.question);
  @override
  _OptionBuilderState createState() =>
      _OptionBuilderState(this.answers, this.choices, this.question);
}

class _OptionBuilderState extends State<OptionBuilder> {
  int groupValue = -1;
  int i = 0;
  final Map choices, answers;
  final String question;
  _OptionBuilderState(this.answers, this.choices, this.question);
  @override
  Widget build(BuildContext context) {
    String answer;
    for (var _ in widget.options) {
      if (_.choice) {
        answer = _.text;
        break;
      }
    }
    return Column(
        children: widget.options.map<Widget>(
      (e) {
        return RadioListTile(
          groupValue: groupValue,
          value: i++ % 4,
          title: Text('${e.text}'),
          onChanged: (int val) {
            setState(() {
              groupValue = val;
              if (e.choice == true) {
                answers[this.question] = true;
                choices[this.question] = e.text;
              } else {
                choices[this.question] = e.text;
              }
            });
            print(val);
          },
          activeColor: HexColor('#ed2a26'),
        );
      },
    ).toList());
  }
}
