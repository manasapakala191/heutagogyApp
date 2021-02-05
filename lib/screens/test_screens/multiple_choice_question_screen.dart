import 'dart:async';

import 'package:connectivity/connectivity.dart';
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
  bool isConnected;
  var connectivity;
  StreamSubscription<ConnectivityResult> subscription;

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
    connectivity = new Connectivity();
    subscription = connectivity.onConnectivityChanged.listen((ConnectivityResult result){
      print(result);
      isConnected = (result != ConnectivityResult.none);
      setState((){});
    });
  }

  @override
  void dispose() {
    timeObject.setEndTime(DateTime.now());
    timeObject.addTimeObjectToStudentPerformance();
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeObject.getStudent(context);
    subscription = connectivity.onConnectivityChanged.listen((ConnectivityResult result){
      print(result);
      isConnected = (result != ConnectivityResult.none);
      setState((){});
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('${singleCorrectTest.subject}'),
      ),
      backgroundColor: HexColor('#f7f7f7'),
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 5,
                      decoration: BoxDecoration(
                          color: HexColor("#ed2a26"),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(7),
                              topLeft: Radius.circular(7))),
                    ),
                    ListTile(
                      title: Text('${singleCorrectTest.testName}'),
                      subtitle: Text('${singleCorrectTest.testDescription}'),
                      isThreeLine: true,
                    ),
                  ],
                ),
              ),
              Column(
                  children: singleCorrectTest.questions
                      .map<Widget>(
                          (e) => QuestionWidget(e, this.answers, this.choices))
                      .toList()),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.all(7),
                width: 50,
                height: 50,
                child: RaisedButton(
                  onPressed: () {
                    if(isConnected){
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
          }
          else{
            showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Quiz not submitted!"),
                      content: Text("You are offline. Connect to a network or read offline course content."),
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
          }
                  },
                  elevation: 10,
                  child: Text("Submit",),
                ),
              )
            ],
          )),
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
