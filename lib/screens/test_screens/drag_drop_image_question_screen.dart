import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/test_type_models/drag_drop_test.dart';
import 'package:heutagogy/models/test_type_models/option_class.dart';
import 'package:heutagogy/models/userModel.dart';
import 'package:heutagogy/screens/score_screens/drag_drop_score.dart';
import 'package:provider/provider.dart';
import 'package:heutagogy/services/database.dart';
import 'package:heutagogy/models/studentProgress.dart';

class DragDropImageScreen extends StatefulWidget {
  final DragDropImageTest dragDropImageTest;
  final String courseID, lessonID, type;

  DragDropImageScreen(this.dragDropImageTest,this.type,this.courseID,this.lessonID, {Key key}) : super(key: key);

  @override
  _DragDropImageScreenState createState() => _DragDropImageScreenState(dragDropImageTest);
}

class _DragDropImageScreenState extends State<DragDropImageScreen> {
  DragDropImageTest dragDropImageTest;
  Map<String, bool> correct;
  Map<String, bool> correct2;
  var choices;

  _DragDropImageScreenState(DragDropImageTest dragDropImageTest) {
    this.dragDropImageTest = dragDropImageTest;
    this.correct = Map();
    this.correct2 = Map();
    this.choices = Map();
    for (var image in this.dragDropImageTest.pictures) {
      correct[image.description] = false;
      correct2[image.description] = false;
      choices[image.description] = null;
    }
  }

  void _updateProgress(){
    var progress = Provider.of<StudentProgress>(context,listen: false);
    // print(choices.values);
    var user = Provider.of<UserModel>(context,listen: false);
    String studentID = user.getID();
    List<String> responses = [];
    for (var response in choices.values) {
        responses.add(response);
    }
    print("Hoyyaa");
    print(responses);
    print("Whyyya");
    int count = 0, total = 0;
    for(var val in correct.values){
      if(val == true){
        count++;
      }
      total++;
    }
    print(count);
    print(total);
    progress.setPerformance(widget.courseID,widget.lessonID,widget.type,count,total);
    progress.addResponses(widget.courseID,widget.lessonID,widget.type,responses);
    DatabaseService().writeProgress(progress.getPerformance(widget.courseID,widget.lessonID,widget.type),studentID,widget.courseID,widget.lessonID,widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(dragDropImageTest.testName,style: TextStyle(color: HexColor("#ed2a26")),),
          backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace_rounded,color: HexColor("#ed2a26")),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              (dragDropImageTest.testDescription == "" || dragDropImageTest.testDescription == null)
                  ? Container()
                  : Center(
                child: Text(
                  dragDropImageTest.testDescription,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20),),
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
      if (correct[image.description]) {
        drops.add(Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
                color: Color.fromARGB(20, 10, 40, 230),
                border: Border.all(width: 2),
                borderRadius: BorderRadius.circular(100)),
            child: Icon(
              Icons.check_circle_rounded,
              color: Color(0xFFAB4E68),
              size: 32,
            )));
      } else {
        drops.add(DraggableImage(image: image, active: correct[image.description]));
      }
      targets.add(
        DragTarget(
          builder: (BuildContext context, List<String> incoming, List rejected) {
            if (!correct2[image.description]) {
              return Container(
                padding: EdgeInsets.only(bottom: 4),
                width: 140,
                height: 128,
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0xFFFDCC0D), width: 2),
                      color: Color(0xFFFDCC0D),
                      // color: HexColor("#ed2a26")
                  ),
                  padding: EdgeInsets.all(10),
                  height: 128,
                  child: Center(
                      child: Text(
                        image.description,
                        style:
                          GoogleFonts.getFont('Spartan'),
                        // TextStyle(
                        //     // color: Colors.white,
                        //     fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Monsterrat'),
                      )),
                ),
              );
            } else {
              return Container(
                padding: EdgeInsets.only(bottom: 4),
                width: 140,
                height: 128,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black54, width: 2),
                        color: Color(0xFFAB4E68)),
                    padding: EdgeInsets.all(10),
                    height: 128,
                    child: Center(
                      child: Text(
                        "Matched",
                        style: TextStyle(
                            fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )),
              );
            }
          },
          onAccept: (data) {
            setState(() {
              correct[data] = true;
              correct2[image.description] = true;
              print(data);
              print(image.description);
              choices[image.description] = image.description;
            });
          },
          onLeave: (data) {
            print(data);
            print(image.description);
            choices[data] = image.description;
          },
          onWillAccept: (data) => data == image.description,
        ),
      );
    }
    targets..shuffle(Random(2));
    for (int i = 0; i < this.dragDropImageTest.pictures.length; i++) {
      body.add(Padding(
          padding: EdgeInsets.only(top: 3, left: 40, right: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[drops[i], targets[i]],
          )));
    }
    body.add(
      SizedBox(height:20)
    );
    body.add(
      MaterialButton(
        minWidth: 75,
        height: 75,
        elevation: 8,
        child: Text("Submit"),
        color: HexColor("#ed2a26"),
        padding: const EdgeInsets.all(5),
        onPressed: (){
          _updateProgress();
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DragDropScoreWidget(
              correct: correct,
              choices: choices,
            )
          ));
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
          // Update progress and write to database
        },
      ),
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              imageUrl: image.picture,
              width: 128,
              height: 128,
              placeholder: (context, data) => CircularProgressIndicator(),
              placeholderFadeInDuration: Duration(milliseconds: 500),
            ),
            clipBehavior: Clip.hardEdge,
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
          ));
    } else {
      return ClipRect(
        child: Container(
          width: 128,
          height: 128,
          child: Center(
            child: Icon(
              Icons.check,
              color: HexColor("#ed2a26"),
            ),
          ),
          color: Colors.lightBlueAccent,
        ),
        clipBehavior: Clip.antiAlias,
      );
    }
  }
}
