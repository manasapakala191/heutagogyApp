import 'package:flutter/material.dart';
import 'dart:math';

import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/screens/score_screens/missing_numbers_result_screen.dart';

class MissingNumbersTestType extends StatelessWidget {

  final range = {'start': 1, 'end': 100};

  final start = 1;

  final end = 100;

  final List<int> randomList =
      List.generate(10, (index) => 1 + Random().nextInt(100 + 1));

  final List<int> answers = List.generate(10, (index) => 0);

  final textEditingControllers =
      List.generate(10, (index) => TextEditingController());

  List<int> getRandomList() {
    return List.generate(10, (index) => start + Random().nextInt(end + 1));
  }

  bool checkNumber(List<int> randomList, int num) {
    for (var i in randomList) {
      if (num == i) {
        return false;
      }
    }
    return true;
  }

  int getIndexInRandomList(int num) {
    int i = 0;
    for (i = 0; i < randomList.length; i++) {
      if (randomList[i] == num) {
        return i;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    print(randomList);
    return Scaffold(
      appBar: AppBar(title: Text('Missing Numbers')),
      backgroundColor: Colors.grey[200],
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: Text(
                            'Find the missing numbers',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height*3/5 + 50,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(color: Colors.white),
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                      itemCount: 100,
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 10,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8
                      ),
                      itemBuilder: (context, index) => !checkNumber(
                              randomList, index+1)
                          ? Container(
                              child: Center(
                              child: TextField(
                                onChanged: (val){
                                  int i = getIndexInRandomList(index+1);
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
                                                  HexColor('#ed2a26'))))),
                            ))
                          : Container(
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(20)
                            ),
                              child: Center(
                                  child: Text(
                                    (index + 1).toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600
                                    ),
                                  )),
                            )),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MissingNumbersResultScreen(
                          answers: randomList,
                          responses: answers,
                        ))
                      );
                    },
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
