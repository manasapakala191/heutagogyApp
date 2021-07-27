import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/progress.dart';
import 'package:heutagogy/models/test_type_models/missing_numbers_test.dart';
import 'package:heutagogy/models/userModel.dart';
import 'package:heutagogy/screens/widgets/customAppBar.dart';
import 'package:heutagogy/screens/widgets/slideHeading.dart';
import 'package:heutagogy/screens/score_screens/missing_numbers_result_screen.dart';
import 'package:heutagogy/services/database.dart';
import 'package:provider/provider.dart';

class MissingNumbersTestType extends StatefulWidget {
  MissingNumbersTest missingNumbersTest;
  String type,lid,cid;
  String typeOfData;
  MissingNumbersTestType(this.missingNumbersTest,this.type,this.cid,this.lid,this.typeOfData);
  @override
  _MissingNumbersTestTypeState createState() => _MissingNumbersTestTypeState(missingNumbersTest);
}

class _MissingNumbersTestTypeState extends State<MissingNumbersTestType> {
  MissingNumbersTest testData;
  _MissingNumbersTestTypeState(this.testData);

  List<int> answers;
  Progress progress1;

  bool checkNumber(List missingList, int num) {
    for (var i in missingList) {
      if (testData.start+ num == i) {
        return false;
      }
    }
    return true;
  }

  int getIndexInMissingList(int num) {
    int i = 0;
    for (i = 0; i < testData.missingList.length; i++) {
      if (testData.missingList[i] == testData.start+ num) {
        return i;
      }
    }
    return 0;
  }

  void _updateProgress() {
    var user = Provider.of<UserModel>(context, listen: false);
    String studentID = user.getID();
    Map<String,int> evaluationMap={"total": 0,"correct":0};
    evaluationMap['total'] = answers.length;
    for (int i = 0; i < testData.missingList.length; i++) {
      if (testData.missingList[i] == answers[i]) {
        evaluationMap['correct'] = evaluationMap['correct'] + 1;
      }
    }
    var progress = Progress(
        name: testData.testName,
        description: testData.testDescription,
        partsDone: evaluationMap["correct"],
        total: evaluationMap["total"],
        responses: answers,
    );
    setState(() {
      progress1=progress;
    });
    print(answers);
    Map<String, dynamic> json = progress.toMap();
    print(json);
    DatabaseService().writeProgress(json,studentID,widget.cid,widget.lid,widget.type);
  }

  bool isConnected;
  var connectivity;
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateConnectivityInformation();
    answers = List.generate(testData.missingList.length, (index) => 0);
    // randomList =
    //     List.generate(testData.missing, (index) => testData.start+1 + Random().nextInt(testData.end-testData.start + 1));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: testData.subject,),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          child: ListView(
          shrinkWrap: true,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SlideHeader(
                    testName: testData.testName,
                    testDescription: testData.testDescription,
                  ),
                  Padding(padding: EdgeInsets.all(8)),
                  Container(
                    // height: MediaQuery.of(context).size.height*3/5 + 50,
                    padding: EdgeInsets.all(5),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    itemCount: testData.end-testData.start+1,
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 8,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8
                    ),
                    itemBuilder: (context, index) => !checkNumber(
                            testData.missingList, index)
                        ? Container(
                      alignment: Alignment.center,
                            child: TextField(
                              onChanged: (val){
                                int i = getIndexInMissingList(index);
                                answers[i] = int.parse(val);
                                print(answers);
                              },
                                decoration: InputDecoration(
                                    hintText: '?',
                                    contentPadding: EdgeInsets.all(3.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(100),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        borderSide: BorderSide(
                                            color:
                                                HexColor('#ed2a26'))))))
                        : Container(
                          decoration: BoxDecoration(
                            color: HexColor("#47A9EB"),
                            borderRadius: BorderRadius.circular(20)
                          ),
                            child: Center(
                                child: Text(
                                  (testData.start+index).toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600
                                  ),
                                )),
                          )),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(15)),
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
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MissingNumbersResultScreen(missingNumbersTest: testData,progress: progress1,)));
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
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => MissingNumbersResultScreen(missingNumbersTest: testData,progress: progress1,)));
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Quiz was NOT submitted!"),
                          content: Text("Internet connection is not stable. Verify and try again later."),
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
          )),
    );
  }
}
