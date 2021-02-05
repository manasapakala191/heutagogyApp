import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/progress.dart';
import 'package:heutagogy/models/studentProgress.dart';
import 'package:heutagogy/models/test_type_models/multiple_choice_question_test.dart';
import 'package:heutagogy/models/test_type_models/option_class.dart';
import 'package:heutagogy/models/test_type_models/question_class.dart';
import 'package:heutagogy/models/time_object_model.dart';
import 'package:heutagogy/models/userModel.dart';
import 'package:heutagogy/screens/score_screens/single_correct_image_response_viewer.dart';
import 'package:heutagogy/services/database.dart';
import 'package:provider/provider.dart';

class MultipleChoiceImageQuestionScreen extends StatefulWidget {
  final ImageQuestionTest imageQuestionTest;
  final String courseID, lessonID, type;
  MultipleChoiceImageQuestionScreen(
      {this.imageQuestionTest, this.type, this.courseID, this.lessonID});
  @override
  _MultipleChoiceImageQuestionScreenState createState() =>
      _MultipleChoiceImageQuestionScreenState(this.imageQuestionTest);
}

class _MultipleChoiceImageQuestionScreenState
    extends State<MultipleChoiceImageQuestionScreen> {
  final timeObject = TimeObject(
      screen: 'Multiple Choice Questions Screen(Image)',
      courseId: 'Default Course ID',
      testId: 'Default Test ID');

  var choices = Map(), answers = Map();
  final ImageQuestionTest imageQuestionTest;
  _MultipleChoiceImageQuestionScreenState(this.imageQuestionTest);

  int count = 0;

  int total = 0;

  List<String> responses = List<String>();
  bool isConnected = true;
  var connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  Map<String, dynamic> getResponseMap() {
    Map<String, dynamic> responseMap = Map<String, dynamic>();
    for (int i = 0; i < imageQuestionTest.questions.length; i++) {
      responseMap[imageQuestionTest.questions[i].question] = responses[i];
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
    var progress = Progress(name:imageQuestionTest.testName,
        description: imageQuestionTest.testDescription,partsDone: count,total: total,responses: responses);
    Map<String, dynamic> json = progress.toMap();
    DatabaseService().writeProgress(
        json, studentID, widget.courseID, widget.lessonID, widget.type);
  }

  @override
  void initState() {
    for (var _ in imageQuestionTest.questions) {
      choices[_.question] = null;
      answers[_.question] = false;
    }
    print(choices);
    print(answers);
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
        title: Text(imageQuestionTest.subject),
      ),
      backgroundColor: HexColor('#f7f7f7'),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 5,
                    decoration: BoxDecoration(
                        color: HexColor("#ed2a26"),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(7),
                            topLeft: Radius.circular(7))),
                  ),
                  ListTile(
                    title: Text('${imageQuestionTest.testName}'),
                    subtitle: Text('${imageQuestionTest.testDescription}'),
                    isThreeLine: true,
                  ),
                ],
              ),
            ),
            Column(
              children: imageQuestionTest.questions
                  .map((e) => QuestionWidget(e, this.choices, this.answers, isConnected))
                  .toList(),
            ),
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
                child: Text("Submit", style: TextStyle(color: Colors.white),),
                color: HexColor("#ed2a26"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class QuestionWidget extends StatelessWidget {
  final ImageQuestionData question;
  final Map choices, answers;
  bool isConnected;
  QuestionWidget(this.question, this.choices, this.answers, this.isConnected);
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
        children: [
          Padding(
            padding: EdgeInsets.all(7),
            child: Text(question.question),
          ),
          ImageOptionBuilder(
              question.options, this.choices, this.answers, question.question, this.isConnected),
        ],
      ),
    );
  }
}

class ImageOptionBuilder extends StatefulWidget {
  final List<ImageChoice> options;
  final Map choices, answers;
  final String question;
  bool isConnected;
  ImageOptionBuilder(this.options, this.choices, this.answers, this.question, this.isConnected);
  @override
  _ImageOptionBuilderState createState() =>
      _ImageOptionBuilderState(this.choices, this.answers, this.question);
}

class _ImageOptionBuilderState extends State<ImageOptionBuilder> {
  int groupValue = -1;

  int i = 0;
  Map choices, answers;
  String question;

  _ImageOptionBuilderState(this.choices, this.answers, this.question);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 3 / 5,
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(
        itemCount: widget.options.length,
        physics: ClampingScrollPhysics(),
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) => RadioListTile(
          onChanged: (int val) {
            setState(
              () {
                groupValue = val;
                if (widget.options[index].correct) {
                  choices[this.question] = widget.options[index].text;
                  answers[this.question] = true;
                } else {
                  choices[this.question] = widget.options[index].text;
                }
              },
            );
          },
          value: index,
          activeColor: HexColor('#ed2a26'),
          groupValue: groupValue,
          // title: Image.network(
          //   widget.options[index].picture,
          //   // scale: 1.5,
          //   fit: BoxFit.fill,
          //   height: MediaQuery.of(context).size.height / 5,
          //   width: MediaQuery.of(context).size.width / 3,
          //   // errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace){
          //   //   return CircularProgressIndicator();
          //   // },
          // ),
          title: widget.isConnected ?widget.options[index].picture!=null && widget.options[index].picture.isNotEmpty
                      ? FadeInImage.assetNetwork(
                          placeholder: "assets/images/loading.gif",
                          image: widget.options[index].picture != null ? widget.options[index].picture : "No image")
                      : Image.asset(
                          "assets/images/loading.gif",
                        ): Image(image: FileImage(File(widget.options[index].picture))),
        ),
      ),
    );
  }
}
