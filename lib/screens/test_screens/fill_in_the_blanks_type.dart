import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart' as faker;
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/progress.dart';
import 'package:heutagogy/models/userModel.dart';
import 'package:heutagogy/screens/widgets/customAppBar.dart';
import 'package:heutagogy/screens/widgets/slideHeading.dart';
import 'package:heutagogy/screens/score_screens/fill_in_the_blanks_result_viewer.dart';
import 'package:heutagogy/models/test_type_models/fill_the_blank_test.dart';
import 'package:heutagogy/services/database.dart';
import 'package:provider/provider.dart';

class FillInTheBlankType extends StatefulWidget {
  FillInBlankTest fillInBlankTest;
  String courseID,lessonID,type;
  String typeOfData;
  FillInTheBlankType(this.fillInBlankTest,this.type,this.courseID,this.lessonID,this.typeOfData);

  @override
  _FillInTheBlankTypeState createState() => _FillInTheBlankTypeState(fillInBlankTest);
}

class _FillInTheBlankTypeState extends State<FillInTheBlankType> {
  FillInBlankTest testData;

  _FillInTheBlankTypeState(this.testData);

  Map<String, bool> data;

  Progress progress1;
  int total = 0;
  int count = 0;

  Map<String,dynamic> responseMap = {
    'totalQuestions': 0,
    'correctAnswers': 0,
  };
  void _updateProgress(){
    var user = Provider.of<UserModel>(context,listen: false);
    String studentID = user.getID();

    responseMap['totalQuestions'] = testData.choices.length;
    for (int i = 0; i < testData.choices.length; i++) {
      if (testData.choices[i].correctText== answers[i]) {
        responseMap['correctAnswers'] = responseMap['correctAnswers'] + 1;
      }
    }
    var progress = Progress(name: testData.testName,description: testData.testDescription,partsDone: responseMap['correctAnswers'],total:responseMap['totalQuestions'] ,responses: answers);
    setState(() {
      progress1=progress;
    });
    Map<String,dynamic> json = progress.toMap();
    print(json);
    DatabaseService().writeProgress(json,studentID,widget.courseID,widget.lessonID,widget.type);
  }
  var connectivity;
  StreamSubscription<ConnectivityResult> subscription;
  bool isConnected;
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

  List answers;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateConnectivityInformation();
    answers = List.generate(testData.choices.length, (index) => '');
    print(testData.testName);
  }
  @override
  Widget build(BuildContext context) {
    final _screenSize=MediaQuery.of(context).size;
    return Scaffold(
        // backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: testData.subject,
        ),
        body: Container(
            padding: EdgeInsets.all(10),
            child: ListView(
              shrinkWrap: true,
              children: [
                SlideHeader(testName: testData.testName,testDescription: testData.testDescription,),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.separated(
                    separatorBuilder: (context,index){
                      return Divider(
                        color: HexColor("607196"),
                        thickness: 1,
                      );
                    },
                    physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: testData.choices.length ,
                      itemBuilder: (context, index) => Container(
                          margin: EdgeInsets.all(15,),
                          padding: EdgeInsets.all(5),
                          constraints: BoxConstraints(
                            minHeight: _screenSize.height*0.1,
                          ),

                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    5, 10, 5, 20),
                                child: Text(testData.choices[index].question,style: TextStyle( fontSize: 17),),
                              ),
                              TextField(
                                onChanged: (val) {
                                  answers[index] = val;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Enter your answer here',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.grey)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: HexColor("#607196"))),
                                ),
                              )
                            ],
                          ))),
                ),
                Padding(padding: EdgeInsets.all(8)),
                (widget.typeOfData == "online")?
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
                    if(isConnected == true){
                        _updateProgress();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FillInTheBlanksResultViewer(fillInBlankTest: testData,progress: progress1,)));
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
                            content: Text("You don't have a stable internet connection. Verify your connection and try again."),
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
                ):Container(),
              ],
            ))
    );
  }
}
