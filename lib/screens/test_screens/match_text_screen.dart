import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/studentProgress.dart';
import 'package:heutagogy/models/test_type_models/match_text_test.dart';
import 'package:heutagogy/models/userModel.dart';
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

  void _updateProgress(){
    var progress = Provider.of<StudentProgress>(context,listen: false);
    var user = Provider.of<UserModel>(context,listen: false);
    String studentID = user.getID();
    List<String> responses = [];
    for (var response in choices.values) {
        responses.add(response);
    }
    print("Hoyaaa");
    print(responses);
    print("Whyyyaa");
    // print(progress.getPerformance(widget.courseID, widget.lessonID));
    int count = 0, total = 0;
    for(var val in data.values){
      if(val == true){
        count++;
      }
      total++;
    }

    progress.setPerformance(widget.courseID,widget.lessonID,widget.type,count,total);
    progress.addResponses(widget.courseID,widget.lessonID,widget.type,responses);
    DatabaseService().writeProgress(progress.getPerformance(widget.courseID,widget.lessonID,widget.type),studentID,widget.courseID,widget.lessonID,widget.type);
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
    if (_matchPicWithText.testDescription != null &&
        _matchPicWithText.testDescription != "") {
      items.add(
        Container(
          padding: EdgeInsets.all(10.0),
          child: Text(
            _matchPicWithText.testDescription,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
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
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.0),
            (!data[x.correctText])
                ? Container(
                    margin: EdgeInsets.only(
                        top: 10, bottom: 20, left: 50, right: 50),
                    // key: UniqueKey(),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: HexColor("#ed2a26"), width: 2),
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
                : Container(
                    // key: UniqueKey(),
                    height: 45.00,
                    margin: EdgeInsets.only(
                        top: 10, bottom: 20, left: 50, right: 50),
                    decoration: BoxDecoration(
                      color: Colors.green,
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        x.correctText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
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
        minWidth: 25,
        height: 75,
        elevation: 8,
        child: Text("Submit"),
        color: HexColor("#ed2a26"),
        padding: const EdgeInsets.all(5),
        onPressed: (){
          _updateProgress();
          showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: Text("Quiz submitted!"),
                content: Text("The Quiz is submitted successfully"),
                actions: [
                  FlatButton(child: Text("Stay"),onPressed: (){
                    Navigator.pop(context);
                  },),
                  FlatButton(child: Text("Leave"),onPressed: (){
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },)
                ],
              );
            }
          );
        },
      ),
    );
    return items;
  }

  @override
  Widget build(BuildContext context) {
    timeObject.getStudent(context);
    //_buildImageInput();
    return Scaffold(
      appBar: AppBar(
        title: Text('testName'),
        backgroundColor: Colors.white,
        actionsIconTheme: IconThemeData(
          color: HexColor("#ed2a26"),
        ),
        iconTheme: IconThemeData(
          color: HexColor("#ed2a26"),
        ),
      ),
      body: Center(
        child: ListView(
          children: _buildImageInput(),
        ),
      ),
    );
  }
}
