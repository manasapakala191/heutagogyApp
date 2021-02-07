import 'package:flutter/material.dart';

import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/progress.dart';
import 'package:heutagogy/models/userModel.dart';
import 'package:heutagogy/screens/handyWidgets/customAppBar.dart';
import 'package:heutagogy/screens/handyWidgets/slideHeading.dart';
import 'package:heutagogy/screens/score_screens/drag_drop_order_score.dart';
import 'package:provider/provider.dart';
import 'package:heutagogy/services/database.dart';
import 'package:heutagogy/models/test_type_models/drag_drop_order_test.dart';

class DragDropOrderScreen extends StatefulWidget {
  final DragDropOrderTest data;
  final String courseID, lessonID, type;
  DragDropOrderScreen(this.data, this.type, this.courseID, this.lessonID);

  @override
  _DragDropOrderScreenState createState() => _DragDropOrderScreenState(data);
}

class _DragDropOrderScreenState extends State<DragDropOrderScreen> {
  DragDropOrderTest testdata;
  List data;
  List choices = [];
  var leftMarked = [];
  var rightMarked = [];
  _DragDropOrderScreenState(this.testdata);

  @override
  void initState() {
    super.initState();
    int i=0;
    data=List(testdata.questions.length);
    choices=List(testdata.questions.length);
    leftMarked=List(testdata.questions.length);
    rightMarked=List(testdata.questions.length);
    for (int i=0;i<testdata.questions.length;i++) {
      data[i]={};
      choices[i]=[];
      leftMarked[i]={};
      rightMarked[i]={};
      for(int j=0;j<testdata.questions[i].elements.length;j++){
        data[i][testdata.questions[i].elements[j]]=false;
        choices[i].add("-");
        leftMarked[i][testdata.questions[i].elements[j]]=false;
        rightMarked[i][testdata.questions[i].elements[j]]=false;
      }
    }
  }

  void _updateProgress() {
    var user = Provider.of<UserModel>(context, listen: false);
    String studentID = user.getID();
    List<String> responses = [];
    for(int i=0;i<choices.length;i++){
      String curr_response="";
      for(String str in choices[i]) {
        curr_response = curr_response + " " + str;
      }
      responses.add(curr_response.trim());
    }
    int count = 0, total = data.length;
    for(int i=0;i<data.length;i++){
      bool flag=false;
      print(data[i].values);
      for(var j in data[i].values){
        if(j==false){
          flag=true;
          break;
        }
      }
      if(!flag){
        count+=1;
      }
    }
    var progress = Progress(
        name: testdata.testName,
        description: testdata.testDescription,
        partsDone: count,
        total: total,
        responses: responses);
    print(responses);
    Map<String, dynamic> json = progress.toMap();
    print(json);
    // DatabaseService().writeProgress(json,studentID,widget.courseID,widget.lessonID,widget.type);
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize=MediaQuery.of(context).size;
    return Scaffold(
        appBar: CustomAppBar(title: testdata.subject,),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SlideHeader(
                  testName: testdata.testName,
                  testDescription: testdata.testDescription,
                ),
                ListView.builder(
                  shrinkWrap: true,
                    itemCount: testdata.questions.length,
                    itemBuilder: (context,idx){
                      return Container(
                        margin: EdgeInsets.all(10),
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Wrap(
                                  alignment: WrapAlignment.start,
                                  direction: Axis.horizontal,
                                  spacing: 5,
                                  runSpacing: 3,
                                  children: _buildDraggables(idx,testdata.questions[idx])..shuffle(Random(2)),
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                //   children: _buildDraggables(idx,testdata.questions[idx])..shuffle(Random(2))
                                // ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: _buildDragTargets(idx,testdata.questions[idx])
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(height: 20,),
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
                ),
              ],
            ),
          ),
        ));
  }
  //
  _buildDraggables(int idx,OrderQuestion orderQuestion) {
    List<Widget> items = [];
    for (var x in orderQuestion.elements) {
      items.add(Draggable<String>(
          data: idx.toString() + " " + x,
          child: Container(
            // width: 80,
            // height: 40,
            constraints: BoxConstraints(
              minWidth: 40,
              minHeight: 40,
              // maxWidth: 80,
            ),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: HexColor("#70D6FF"),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                leftMarked[idx][x] == true
                        ? Icon(
                      Icons.done_outline,
                      color: Colors.black,
                      size: 15,
                    )
                        : Padding(padding: EdgeInsets.all(0)),
                    Text(
                  x,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ],
            )
          ),
          childWhenDragging: Material(
              child: Container(
            height: 40,
                constraints: BoxConstraints(
                  minWidth: 40,
                ),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: HexColor("#70D6FF"),
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              x,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          )),
          feedback: Material(
              color: Colors.transparent,
              child: Container(
                height: 40,
                constraints: BoxConstraints(
                  minWidth: 40,
                ),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: HexColor("#70D6FF"),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  x,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ))));
    }

    return items;
  }

  _buildDragTargets(int idx,OrderQuestion orderQuestion) {
    List<Widget> items = [];
    for (int i = 0; i < orderQuestion.elements.length; i++) {
      String x = orderQuestion.elements[i];
      if (rightMarked[idx][x]) {
        items.add(
          DragTarget<String>(
            builder:
                (BuildContext context, List<String> incoming, List rejected) {
              return Container(
                  alignment: Alignment.center,
                  constraints: BoxConstraints(minHeight: 40, minWidth: 40),
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: HexColor("#607196"),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.done,
                        color: Colors.white,
                      ),
                      Text(
                        choices[idx][i],
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ));
            },
            onWillAccept: (t) {
              List<String> strings=t.split(" ");
              print(strings[0]+ " "+idx.toString());
              if(strings[0]==idx.toString())
                return true;
              return false;
            },
            onAccept: (t) {
              print(":)");
              print(x);
              List<String> strings=t.split(" ");
              setState(
                () {
                  print("i t:" + t);
                  print("i x:" + x);
                  print(idx);
                  print(data.length);
                  if (strings[1] == x) data[idx][x] = true;
                  choices[idx][i] = strings[1];
                  leftMarked[idx][strings[1]] = true;
                  rightMarked[idx][x] = true;
                },
              );
            },
            onLeave: (t) {

            },
          ),
        );
      } else {
        items.add(
          DragTarget<String>(
            builder:
                (BuildContext context, List<String> incoming, List rejected) {
              return Container(
                alignment: Alignment.center,
                // width: 50,
                // height: 50,
                constraints: BoxConstraints(minHeight: 40, minWidth: 40),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: HexColor("#607196"),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  i.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              );
            },
            onWillAccept: (t) {
              List<String> strings=t.split(" ");
              print(strings[0]+ " "+idx.toString());
              if(strings[0]==idx.toString())
                return true;
              return false;
            },
            onAccept: (t) {
              List<String> strings=t.split(" ");
              print(":)");
              print(x);
              setState(
                () {
                  print("i t:" + t);
                  print("i x:" + x);
                  print(idx);
                  print(data[idx][x]);
                  if (strings[1] == x) data[idx][x] = true;
                  choices[idx][i] = strings[1];
                  leftMarked[idx][strings[1]] = true;
                  rightMarked[idx][x] = true;
                },
              );
            },
            onLeave: (t) {
            },
          ),
        );
      }
    }
    return items;
  }
}

