import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
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
import 'package:heutagogy/screens/score_screens/drag_drop_image_score.dart';
import 'package:heutagogy/screens/widgets/customAppBar.dart';
import 'package:heutagogy/screens/widgets/slideHeading.dart';
import 'package:provider/provider.dart';
import 'package:heutagogy/services/database.dart';
import 'package:heutagogy/models/studentProgress.dart';

class DragDropImageScreen extends StatefulWidget {
  final DragDropImageTest dragDropImageTest;
  final String courseID, lessonID, type;
  final String typeOfData;
  
  DragDropImageScreen(
      this.dragDropImageTest, this.type, this.courseID, this.lessonID, this.typeOfData,
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
  bool isConnected;
  var connectivity;
  Progress _progress1;
  StreamSubscription<ConnectivityResult> subscription;


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
  void initState(){
    super.initState();
    print("Called init state");
    _updateConnectivityInformation();
  }

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
    setState(() {
      _progress1=progress;
    });
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

    for (int i=0;i<dragDropImageTest.pictures.length;i++) {
    var image =dragDropImageTest.pictures[i];
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
            DraggableImage(image: image, active: correct[image.description], typeOfData: widget.typeOfData,));
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
              print(data);
              if(data == image.description)
              correct[data] = true;
              leftMarked[data] = true;
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
    if(widget.typeOfData == "online"){
      body.add(
      MaterialButton(
        minWidth: 85,
        height: 75,
        elevation: 8,
        child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: 15),),
        color: Colors.redAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        onPressed: () {
          if(isConnected == true){
              _updateProgress();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DragDropImageScore(progress: _progress1,dragDropImageTest: dragDropImageTest,)));
              // showDialog(
              //     context: context,
              //     builder: (BuildContext context) {
              //       return AlertDialog(
              //         title: Text("Quiz submitted!"),
              //         content: Text("The Quiz is submitted successfully"),
              //         actions: [
              //           FlatButton(
              //             child: Text("Stay"),
              //             onPressed: () {
              //               Navigator.pop(context);
              //             },
              //           ),
              //           FlatButton(
              //             child: Text("Leave"),
              //             onPressed: () {
              //               Navigator.pop(context);
              //               Navigator.pop(context);
              //             },
              //           )
              //         ],
              //       );
              //     });
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
          // Update progress and write to database
        },
      ),
    );
    }
    return body;
  }
}

class DraggableImage extends StatelessWidget {
  final PicturePair image;
  final bool active;
  final String typeOfData;

  DraggableImage({this.image, this.active, this.typeOfData});

  @override
  Widget build(BuildContext context) {
    if (!this.active) {
      return Draggable<String>(
          data: image.description,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: (typeOfData == "online") ? CachedNetworkImage(
              imageUrl: image.picture,
              width: 128,
              height: 128,
              placeholder: (context, data) => CircularProgressIndicator(),
              placeholderFadeInDuration: Duration(milliseconds: 500),
            ): Image(image: FileImage(File(image.picture)),height: 125,width: 125,),
            clipBehavior: Clip.hardEdge,
          ),
          feedback: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: (typeOfData == "online") ? CachedNetworkImage(
              imageUrl: image.picture,
              width: 128,
              height: 128,
              placeholder: (context, data) => CircularProgressIndicator(),
              placeholderFadeInDuration: Duration(milliseconds: 500),
            ): Image(image: FileImage(File(image.picture)),height: 125,width: 125,),
            // CachedNetworkImage(
            //   placeholder: (context, url) => CircularProgressIndicator(),
            //   placeholderFadeInDuration: Duration(milliseconds: 100),
            //   imageUrl: image.picture,
            //   width: 128,
            //   height: 128,
            // ),
            // child: Image(image: FileImage(File(image.picture)),height: 125,width: 125,),
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
