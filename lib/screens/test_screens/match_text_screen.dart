import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/progress.dart';
import 'package:heutagogy/models/studentProgress.dart';
import 'package:heutagogy/models/test_type_models/match_text_test.dart';
import 'package:heutagogy/models/userModel.dart';
import 'package:heutagogy/screens/handyWidgets/customAppBar.dart';
import 'package:heutagogy/screens/handyWidgets/slideHeading.dart';
import 'package:heutagogy/screens/score_screens/result_screen.dart';
import 'package:heutagogy/services/database.dart';
import 'package:provider/provider.dart';
import 'package:heutagogy/models/time_object_model.dart';

class MatchText extends StatefulWidget {
  final MatchPicWithText matchPicWithText;
  final String type, courseID, lessonID;
  MatchText({this.matchPicWithText,this.type,this.courseID, this.lessonID});
  @override
  _MatchTextState createState() => _MatchTextState();
}

class _MatchTextState extends State<MatchText> {
  MatchPicWithText _matchPicWithText;
  Map<String, bool> data;
  var choices = Map();

  int total = 0;
  int count = 0;

  List<String> responses = [];

  void _updateProgress(){
    var user = Provider.of<UserModel>(context,listen: false);
    String studentID = user.getID();
    for (var response in choices.values) {
        responses.add(response);
    }
    print("Hoyaaa");
    print(responses);
    print("Whyyyaa");
    // print(progress.getPerformance(widget.courseID, widget.lessonID));
    for(var val in data.values){
      if(val == true){
        count++;
      }
      total++;
    }
    var progress = Progress(name: _matchPicWithText.testName,description: _matchPicWithText.testDescription,partsDone: count,total: total,responses: responses);
    Map<String,dynamic> json = progress.toMap();
    DatabaseService().writeProgress(json,studentID,widget.courseID,widget.lessonID,widget.type);
  }

  final timeObject  = TimeObject(
    screen: 'Match Text Test Screen',
    courseId: 'Default Course ID',
    testId: 'Default Test ID'
  );

  @override
  void initState() {
    _matchPicWithText = widget.matchPicWithText;
    // Uncomment the following to test this out
    timeObject.setStartTime(DateTime.now());
    // _matchPicWithText = new MatchPicWithText(
    //   testName: "Lorem ipsum",
    //   testDescription: "Type the name of the picture in the given box:",
    //   subject: "Something",
    //   choices: [
    //     PictureData(
    //       picture:
    //           "http://may123.pythonanywhere.com/media/picture_text_input/baby.png",
    //       correctText: "baby",
    //     ),
    //     PictureData(
    //       picture:
    //           "http://may123.pythonanywhere.com/media/picture_text_input/cat_XTqprK4.png",
    //       correctText: "cat",
    //     ),
    //   ],
    // );


    data = Map<String, bool>();
    for (var choice in _matchPicWithText.choices) {
      data[choice.correctText] = false;
      choices[choice.correctText] = null;
    }
    super.initState();
  }

  @override
  void dispose(){
    timeObject.setEndTime(DateTime.now());
    timeObject.addTimeObjectToStudentPerformance();
    super.dispose();
  }

  List<Widget> _buildImageInput() {
    List<Widget> items = [];
    items.add(SlideHeader(
      testName: _matchPicWithText.testName,
      testDescription: _matchPicWithText.testDescription,
    ));
    for (var x in _matchPicWithText.choices) {
      items.add(
        Column(
          key: ObjectKey(x),
          children: <Widget>[
            SizedBox(height: 20.0),
            CachedNetworkImage(
              imageUrl: x.picture,
              width: 250,
              height: 250,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20.0),
            // (!data[x.correctText])?
            Container(
                    margin: EdgeInsets.only(
                        top: 10, bottom: 20, left: 50, right: 50),
                    // key: UniqueKey(),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: HexColor("#7F6A93"), width: 2),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type here",
                      ),
                      onChanged: (txt) {
                        if (x.correctText.toString().toLowerCase() ==
                            txt.toLowerCase()) {
                          setState(() {
                            data[txt] = true;
                            choices[txt] = txt;
                          });
                        }
                        else{
                          choices[x.correctText] = txt;
                        }
                      },
                      readOnly: (data[x.correctText]),
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                // : Container(
                //     // key: UniqueKey(),
                //     height: 45.00,
                //     margin: EdgeInsets.only(
                //         top: 10, bottom: 20, left: 50, right: 50),
                //     decoration: BoxDecoration(
                //       color: Colors.green,
                //         border: Border.all(color: Colors.green, width: 2),
                //         borderRadius: BorderRadius.circular(20)),
                //     child: Center(
                //       child: Text(
                //         x.correctText,
                //         textAlign: TextAlign.center,
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 18,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //   ),
          ],
        ),
      );
    }
    items.add(
      Padding(
        padding: EdgeInsets.only(bottom: 40),
      ),
    );
    items.add(
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
    );
    return items;
  }

  @override
  Widget build(BuildContext context) {
    timeObject.getStudent(context);
    //_buildImageInput();
    return Scaffold(
      appBar: CustomAppBar(
        title: _matchPicWithText.subject,
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: _buildImageInput(),
        ),
      ),
    );
  }
}
