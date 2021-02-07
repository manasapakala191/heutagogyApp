import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/progress.dart';
import 'package:heutagogy/models/test_type_models/math_match.dart';
import 'package:heutagogy/models/userModel.dart';
import 'package:heutagogy/screens/handyWidgets/customAppBar.dart';
import 'package:heutagogy/screens/handyWidgets/slideHeading.dart';
import 'package:provider/provider.dart';
import 'package:heutagogy/services/database.dart';
import 'package:heutagogy/models/studentProgress.dart';

class MathMatchScreen extends StatefulWidget {
  final MathMatchTest data;
  final String courseID,lessonID,type;
  MathMatchScreen(this.data,this.type,this.courseID,this.lessonID);

  @override
  _MathMatchScreenState createState() => _MathMatchScreenState(data);
}

class _MathMatchScreenState extends State<MathMatchScreen> {
  MathMatchTest testdata;
  Map<String, dynamic> data;
  Map<String,dynamic> choices = Map<String,dynamic>();
  var leftMarked = Map();
  var rightMarked = Map();

  _MathMatchScreenState(this.testdata);

  @override
  void initState() {
    super.initState();
    data = Map<String, dynamic>();
    for (var x in testdata.questions) {
      data[x.second] = false;
      choices[x.second] = null;
      leftMarked[x.second] = false;
      rightMarked[x.second] = false;
    }
  }

  void _updateProgress() {
    var user = Provider.of<UserModel>(context,listen: false);
    String studentID = user.getID();
    List<String> responses = [];
    for (var response in choices.values) {
      responses.add(response);
    }
    int count = 0, total = 0;
    for (var val in data.values) {
      if (val == true) {
        count++;
      }
      total++;
    }
    var progress = Progress(name: testdata.testName,description: testdata.testDescription,partsDone: count,total: total,responses: responses);
    Map<String,dynamic> json = progress.toMap();
    DatabaseService().writeProgress(json,studentID,widget.courseID,widget.lessonID,widget.type);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drags = _buildDraggables();
    List<Widget> dragTargets = _buildDragTargets();
    dragTargets..shuffle(Random(2));
    List<Widget> rows = [];
    rows.add(
      SlideHeader(testName: testdata.testName,testDescription: testdata.testDescription,)
    );
    for (int i = 0; i < drags.length; i++) {
      rows.add(Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[drags[i], dragTargets[i]],
        ),
      ));
    }
    rows.add(
      SizedBox(height: 20),
    );
    rows.add(
        MaterialButton(
          minWidth: 85,
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
    return Scaffold(
        appBar: CustomAppBar(title: testdata.testName,),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: rows,
            ),
          ),
        ));
  }

  _buildDraggables() {
    List<Widget> items = [];
    for (var x in testdata.questions) {
      items.add(Draggable<String>(
          data: x.second,
          child: Container(
            width: 115,
            height: 80,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 10, left: 40),
            decoration: BoxDecoration(
                color: HexColor("#6CBAEF"),
                borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: leftMarked[x.second] == true
                ? Icon(
                    Icons.done_outline,
                    color: Colors.white,
                    size: 32,
                  )
                : Text(
                    x.second,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
          ),
          childWhenDragging: Material(
              child: Container(
            width: 115,
            height: 80,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 10, left: 40),
            decoration: BoxDecoration(
                color: HexColor("#6CBAEF"),
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              x.second,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )),
          feedback: Material(
              color: Colors.transparent,
              child: Container(
                width: 115,
                height: 80,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 10, left: 40),
                decoration: BoxDecoration(
                    color: HexColor("#6CBAEF"),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  x.second,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ))));
    }

    return items;
  }

  _buildDragTargets() {
    List<Widget> items = [];
    for (var x in testdata.questions) {
      if (rightMarked[x.second]) {
        items.add(
          Container(
            width: 105,
            height: 80,
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 10, right: 40),
            decoration: BoxDecoration(
                color: HexColor("7F6A93"),
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              "Matched",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      } else {
        items.add(
          DragTarget<String>(
            builder:
                (BuildContext context, List<String> incoming, List rejected) {
              return Container(
                width: 105,
                height: 80,
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 10, right: 40),
                decoration: BoxDecoration(
                    color: HexColor("#7F6A93"),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  x.first,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              );
            },
            onWillAccept: (t) => true,
            onAccept: (t) {
              print(":)");
              print(x.second);
              setState(
                () {
                  if(t == x.second)
                  data[x.second] = true;
                  choices[x.second] = x.second;
                  leftMarked[x.second] = true;
                  rightMarked[x.second] = true;
                },
              );
            },
            onLeave: (t) {
              print(":(");
              print(t);
              print(x.second);
              // setState(() {
              //   choices[t] = x.second;
              //   leftMarked[t] = true;
              //   rightMarked[x.second] = true;
              // });
            },
          ),
        );
      }
    }
    return items;
  }
}
