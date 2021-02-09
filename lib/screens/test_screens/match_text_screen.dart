import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/progress.dart';
import 'package:heutagogy/models/studentProgress.dart';
import 'package:heutagogy/models/test_type_models/match_text_test.dart';
import 'package:heutagogy/models/userModel.dart';
import 'package:heutagogy/screens/score_screens/result_screen.dart';
import 'package:heutagogy/services/database.dart';
import 'package:heutagogy/services/localFileService.dart';
import 'package:provider/provider.dart';
import 'package:heutagogy/models/time_object_model.dart';

class MatchText extends StatefulWidget {
  final MatchPicWithText matchPicWithText;
  final String type, courseID, lessonID;
  final String typeOfData;
  MatchText({this.matchPicWithText,this.type,this.courseID, this.lessonID, this.typeOfData});
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
  bool isConnected;
  var connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  void _updateProgress(){
    var user = Provider.of<UserModel>(context,listen: false);
    String studentID = user.getID();
    for (var response in choices.values) {
        responses.add(response);
    }
    print(responses);
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

  _updateConnectivityInformation() async {
      connectivity = new Connectivity();
      isConnected = ((await connectivity.checkConnectivity()) != ConnectivityResult.none);
      setState((){});
      subscription = connectivity.onConnectivityChanged.listen((ConnectivityResult result){
        print("Subscription result below");
        print(result);
        setState((){
          isConnected = (result != ConnectivityResult.none);
        });
      });
      subscription.cancel();
  }


  @override
  void initState() {
    super.initState();
    print("Called init state");
    _updateConnectivityInformation();
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
    // print("Size is: ");
    // print(_matchPicWithText.choices.length);
    for (var x in _matchPicWithText.choices) {
      print("Image is: ");
      print(x.picture);
      print(isConnected);
      items.add(
        Column(
          key: ObjectKey(x),
          children: <Widget>[
            SizedBox(height: 20.0),
            (widget.typeOfData == "online") ? CachedNetworkImage(
              imageUrl: x.picture,
              width: 128,
              height: 128,
              placeholder: (context, data) => CircularProgressIndicator(),
              placeholderFadeInDuration: Duration(milliseconds: 500),
            ): Image(image: FileImage(File(x.picture)),height: 125,width: 125,),
            SizedBox(height: 20.0),
            // (!data[x.correctText])?
            Container(
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
    if(widget.typeOfData == "online"){
      items.add(
      MaterialButton(
        minWidth: 25,
        height: 75,
        elevation: 8,
        child: Text("Submit"),
        color: HexColor("#ed2a26"),
        padding: const EdgeInsets.all(5),
        onPressed: (){
          if(isConnected == true){
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
                      title: Text("Quiz was NOT submitted!"),
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
      ),
    );
    }
    return items;
  }
 
  @override
  Widget build(BuildContext context) {
    timeObject.getStudent(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.matchPicWithText.testName),
      ),
      body: Center(
        child: ListView(
          children: _buildImageInput(),
        ),
      ),
    );
  }
}
