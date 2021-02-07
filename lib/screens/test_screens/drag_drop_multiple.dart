import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/test_type_models/drag_drop_multiple_test.dart';
import 'package:heutagogy/models/progress.dart';
import 'package:heutagogy/screens/handyWidgets/customAppBar.dart';
import 'package:heutagogy/screens/handyWidgets/slideHeading.dart';
import 'dart:math';

import 'package:heutagogy/screens/score_screens/drag_drop_multiple_score.dart';

class DragDropMultipleScreen extends StatefulWidget {
  final DragDropMultipleTest data;
  final String courseID, lessonID, type;
  DragDropMultipleScreen(this.data, this.type, this.courseID, this.lessonID);
  @override
  _DragDropMultipleScreenState createState() =>
      _DragDropMultipleScreenState(data);
}

class _DragDropMultipleScreenState extends State<DragDropMultipleScreen> {
  Map<String, dynamic> data;
  // DragDropMultipleTest testData;
  DragDropMultipleTest testdata;
  Map<String, dynamic> choices = Map<String, dynamic>();
  var leftMarked = Map();

  Progress progress1;
  _DragDropMultipleScreenState(this.testdata);

  void _updateProgress() {
    // var user = Provider.of<UserModel>(context,listen: false);
    // String studentID = user.getID();
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
    print(data);
    print(responses);
    var progress = Progress(
        name: testdata.testName,
        description: testdata.testDescription,
        partsDone: count,
        total: total,
        responses: responses);
    setState(() {
      progress1 = progress;
    });
    Map<String, dynamic> json = progress.toMap();
    // DatabaseService().writeProgress(json,studentID,widget.courseID,widget.lessonID,widget.type);
  }

  @override
  void initState() {
    // TODO: implement initState
    // testdata = DragDropMultipleTest.fromJSON(json);
    data = Map<String, dynamic>();
    for (var x in testdata.questions) {
      data[x.second] = false;
      choices[x.second] = null;
      leftMarked[x.second] = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(title: testdata.subject,),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          shrinkWrap: true,
          children: [
            SlideHeader(
              testName: testdata.testName,
              testDescription: testdata.testDescription,
            ),
            Container(
              height: _screenSize.height * 0.4,
              margin: EdgeInsets.all(8),
              child: Wrap(
                spacing: 10,
                children: _buildDraggables(_screenSize)..shuffle(Random(2)),
              ),
            ),
            SizedBox(
              width: _screenSize.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _buildDragTargets(_screenSize),
              ),
            ),
            SizedBox(height: 20),
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
            // Navigator.push(context, MaterialPageRoute(builder: (context) => DragDropMultipleScore(dragDropMultipleTest: testdata,progress: progress1,)));
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

  _buildDraggables(var screenSize) {
    List<Widget> items = [];
    for (int i = 0; i < testdata.questions.length; i++) {
      var x = testdata.questions[i];
      items.add(Draggable<String>(
          data: i.toString(),
          child: Card(
            margin: EdgeInsets.only(top: 10),
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            color: HexColor("#C2EABA"),
            child: Container(
              alignment: Alignment.center,
              width: screenSize.width * 0.2,
              constraints: BoxConstraints(
                minHeight: screenSize.height * 0.1,
                minWidth: screenSize.width * 0.1,
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  leftMarked[x.second] == true
                      ? Icon(
                          Icons.done_outline,
                          color: Colors.blueGrey,
                          size: 15,
                        ) : Padding(padding: EdgeInsets.zero),
                  Text(
                          x.second,
                          style: TextStyle(color: Colors.blueGrey, fontSize: 17,fontWeight: FontWeight.w500),
                        ),
                ],
              ),
            ),
          ),
          childWhenDragging: Material(
              child: Container(
            alignment: Alignment.center,
            width: screenSize.width * 0.2,
            height: screenSize.height * 0.1,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              x.second,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )),
          feedback: Material(
              color: Colors.transparent,
              child: Container(
                alignment: Alignment.center,
                width: screenSize.width * 0.2,
                height: screenSize.height * 0.1,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: HexColor("#C2EABA"),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  x.second,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 16),
                ),
              ))));
    }
    return items;
  }

  _buildDragTargets(var screenSize) {
    List<Widget> items = [];
    for (var x in testdata.categories) {
      items.add(
        DragTarget<String>(
          builder:
              (BuildContext context, List<String> incoming, List rejected) {
            return Card(
              margin: EdgeInsets.only(top: 10),
              elevation: 10,
              child: Container(
                alignment: Alignment.center,
                width: screenSize.width / testdata.categories.length - 15,
                height: screenSize.height * 0.15,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: HexColor("#607196"),
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  x,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            );
          },
          onWillAccept: (t) {
            print(t);
            // if(testdata.questions[int.parse(t)].first==x)
            return true;
          },
          onAccept: (t) {
            print(":)");
            print(t);
            String second = testdata.questions[int.parse(t)].second;
            setState(
              () {
                if (testdata.questions[int.parse(t)].first == x)
                  data[second] = true;
                choices[second] = testdata.questions[int.parse(t)].first;
                leftMarked[second] = true;
              },
            );
          },
          onLeave: (t) {
            // print(":(");
            print(t);
          },
        ),
      );
    }
    return items;
  }
}
