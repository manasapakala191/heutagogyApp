import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/progress.dart';
import 'package:heutagogy/models/test_type_models/drag_drop_test.dart';
import 'package:heutagogy/models/test_type_models/option_class.dart';
import 'package:heutagogy/models/userModel.dart';
import 'package:heutagogy/screens/handyWidgets/customAppBar.dart';
import 'package:heutagogy/screens/handyWidgets/slideHeading.dart';
import 'package:provider/provider.dart';
import 'package:heutagogy/services/database.dart';
import 'package:heutagogy/models/studentProgress.dart';

class DragDropImageScreen extends StatefulWidget {
  final DragDropImageTest dragDropImageTest;
  final String courseID, lessonID, type;

  DragDropImageScreen(
      this.dragDropImageTest, this.type, this.courseID, this.lessonID,
      {Key key})
      : super(key: key);

  @override
  _DragDropImageScreenState createState() =>
      _DragDropImageScreenState(dragDropImageTest);
}

class _DragDropImageScreenState extends State<DragDropImageScreen> {
  DragDropImageTest dragDropImageTest;
  Map<String, dynamic> correct;
  Map<String, bool> leftMarked;
  Map<String,bool> rightMarked;
  Map<String,dynamic> choices;

  _DragDropImageScreenState(DragDropImageTest dragDropImageTest) {
    this.dragDropImageTest = dragDropImageTest;
    this.correct = Map<String,dynamic>();
    this.leftMarked = Map();
    this.choices = Map<String,dynamic>();
    this.rightMarked = Map();
    for (var image in this.dragDropImageTest.pictures) {
      correct[image.description] = false;
      leftMarked[image.description] = false;
      rightMarked[image.description] = false;
      choices[image.description] = null;
    }
  }

  void _updateProgress(){
    var user = Provider.of<UserModel>(context,listen: false);
    String studentID = user.getID();
    List<String> responses = [];
    for (var response in choices.values) {
      responses.add(response);
    }
    int count = 0, total = 0;
    for (var val in correct.values) {
      if (val == true) {
        count++;
      }
      total++;
    }
    var progress = Progress(name :dragDropImageTest.testName,description: dragDropImageTest.testDescription,partsDone:count,total: total,responses: responses);
    Map<String, dynamic> json = progress.toMap();
    print(json);
    DatabaseService().writeProgress(
        json, studentID, widget.courseID, widget.lessonID, widget.type);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(
        title: dragDropImageTest.subject,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SlideHeader(
                testName: dragDropImageTest.testName,
                testDescription: dragDropImageTest.testDescription,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Column(
                children: _builder(correct),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _builder(Map correct) {
    List<Widget> body = [];
    List<Widget> drops = [];
    List<Widget> targets = [];

    for (var image in dragDropImageTest.pictures) {
      if (leftMarked[image.description]) {
        drops.add(Container(
            width: 128,
            height: 128,
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(15)),
            child: Icon(
              Icons.done_rounded,
              color: HexColor("C2EABA"),
              size: 40,
            )));
      } else {
        drops.add(
            DraggableImage(image: image, active: correct[image.description]));
      }
      targets.add(
        DragTarget(
          builder: (BuildContext context, List<String> incoming, List rejected) {
            if (!rightMarked[image.description]) {
              return Container(
                padding: EdgeInsets.only(bottom: 4),
                width: 120,
                height: 120,
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: HexColor("C2EABA"),
                    // color: HexColor("#ed2a26")
                  ),
                  padding: EdgeInsets.all(10),
                  height: 128,
                  child: Center(
                      child: Text(
                    image.description,
                    style: GoogleFonts.getFont('Spartan'),
                    // TextStyle(
                    //     // color: Colors.white,
                    //     fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Monsterrat'),
                  )),
                ),
              );
            } else {
              return Container(
                padding: EdgeInsets.only(bottom: 4),
                width: 120,
                height: 120,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: HexColor("#3B6064")),
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        "Matched",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
              );
            }
          },
          onAccept: (data) {
            print("This is correct :)");
            setState(() {
              if(data == image.description)
              correct[data] = true;
              leftMarked[image.description] = true;
              rightMarked[image.description] = true;
              print(data);
              print(image.description);
              choices[image.description] = data;
            });
          },
          onLeave: (data) {
            print("This is wrong :(");
            print(data);
            print(image.description);
            // setState(() {
            //     leftMarked[data] = true;
            //     rightMarked[image.description] = true;
            //     choices[data] = image.description;
            // });
          },
          onWillAccept: (data) => true,
        ),
      );
    }
    targets..shuffle(Random(2));
    for (int i = 0; i < this.dragDropImageTest.pictures.length; i++) {
      body.add(Padding(
          padding: EdgeInsets.only(top: 3, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[drops[i],Padding(padding: EdgeInsets.all(10)), targets[i]],
          )));
    }
    body.add(SizedBox(height: 20));
    body.add(
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
    return body;
  }
}

class DraggableImage extends StatelessWidget {
  final PicturePair image;
  final bool active;

  DraggableImage({this.image, this.active});

  @override
  Widget build(BuildContext context) {
    if (!this.active) {
      return Draggable<String>(
          data: image.description,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
            ),
            child: ClipRRect(
              child: CachedNetworkImage(
                imageUrl: image.picture,
                width: 128,
                height: 128,
                fit: BoxFit.contain,
                placeholder: (context, data) => CircularProgressIndicator(),
                placeholderFadeInDuration: Duration(milliseconds: 500),
              ),
              clipBehavior: Clip.hardEdge,
            ),
          ),
          feedback: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              placeholder: (context, url) => CircularProgressIndicator(),
              placeholderFadeInDuration: Duration(milliseconds: 100),
              imageUrl: image.picture,
              width: 128,
              height: 128,
            ),
            clipBehavior: Clip.hardEdge,
          ),
          childWhenDragging: Container(
            width: 128,
            height: 128,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.blueGrey,
            ),

          ));
    } else {
      return ClipRect(
        child: Container(
          width: 128,
          height: 128,
          child: Center(
            child: Icon(
              Icons.add,
            ),
          ),
          // color: Colors.lightBlueAccent,
        ),
        clipBehavior: Clip.antiAlias,
      );
    }
  }
}
