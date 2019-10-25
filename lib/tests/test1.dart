import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class Test1Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Test1PageState();
}

class Test1PageState extends State<Test1Page> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Container(
            child: Column(
          children: <Widget>[
            Question1(),
            Padding(padding: EdgeInsets.only(top: 40),),
            Question2(),
          ],
        )),
    );
  }
}

class Question1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Question1State();
}

class Question1State extends State<StatefulWidget> {
  List<bool> select1 = [false, false];
  List<bool> select2 = [false, false];
  List<bool> select3 = [false, false];
  List<bool> select4 = [false];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Center(
            child: Text(
          "Q1 Identify the family memebers and the relatives",
          style: TextStyle(fontSize: 18),
        )),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              child: Text(
                "Father",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: () {
                print("okay");
              },
            ),
            Padding(padding: EdgeInsets.fromLTRB(5, 0, 5, 0)),
            MaterialButton(
              child: Text(
                "Baby",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: () {
                print("okay");
              },
            ),
            Padding(padding: EdgeInsets.fromLTRB(5, 0, 5, 0)),
            MaterialButton(
              child: Text(
                "Father",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: () {
                print("okay");
              },
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              child: Text(
                "Grandfather",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: () {
                print("okay");
              },
            ),
            Padding(padding: EdgeInsets.fromLTRB(5, 0, 5, 0)),
            Padding(padding: EdgeInsets.fromLTRB(5, 0, 5, 0)),
            MaterialButton(
              child: Text(
                "Brother",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: () {
                print("okay");
              },
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              child: Text(
                "Sister",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: () {
                print("okay");
              },
            ),
            Padding(padding: EdgeInsets.fromLTRB(5, 0, 5, 0)),
            MaterialButton(
              child: Text(
                "Grandmother",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: () {
                print("okay");
              },
            ),
            Padding(padding: EdgeInsets.fromLTRB(5, 0, 5, 0)),
          ],
        ),
      ],
    ));
  }
}

class Question2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Question2State();
}

class Question2State extends State<StatefulWidget> {
  List<bool> select1 = [false, false];
  List<bool> select2 = [false, false];
  List<bool> select3 = [false, false];
  List<bool> select4 = [false];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Center(
            child: Text(
          "Q2 Identify the professions",
          style: TextStyle(fontSize: 18),
        )),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              child: Text(
                "Doctor",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: () {
                print("okay");
              },
            ),
            Padding(padding: EdgeInsets.fromLTRB(5, 0, 5, 0)),
            MaterialButton(
              child: Text(
                "Police",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: () {
                print("okay");
              },
            ),
            Padding(padding: EdgeInsets.fromLTRB(5, 0, 5, 0)),
            MaterialButton(
              child: Text(
                "Nurse",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: () {
                print("okay");
              },
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              child: Text(
                "Teacher",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: () {
                print("okay");
              },
            ),
            Padding(padding: EdgeInsets.fromLTRB(5, 0, 5, 0)),
            MaterialButton(
              child: Text(
                "Lawyer",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: () {
                print("okay");
              },
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              child: Text(
                "Carpenter",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: () {
                print("okay");
              },
            ),
            Padding(padding: EdgeInsets.fromLTRB(5, 0, 5, 0)),
            MaterialButton(
              child: Text(
                "Tailor",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: () {
                print("okay");
              },
            ),
            Padding(padding: EdgeInsets.fromLTRB(5, 0, 5, 0)),
          ],
        ),
//
  //            ToggleButtons(
  //              children: <Widget>[
  //                Text(
  //                  "Carpenter",
  //                  style: TextStyle(fontSize: 16),
  //                ),
  //                Text(
  //                  "Lawyer",
  //                  style: TextStyle(fontSize: 16),
  //                ),
  //
  //              ],
  //              onPressed: (int index) {
  //                int count = 0;
  //                select1.forEach((bool val) {
  //                  if (val) count++;
  //                });
  //
  //                if (select1[index] && count < 0)
  //                  return;
  //
  //                setState(() {
  //                  select1[index] = !select1[index];
  //                });
  //              },
  //              borderRadius: BorderRadius.circular(10),
  //              isSelected: select1,
  //            ),
  //            Padding(padding: EdgeInsets.fromLTRB(5, 5, 5, 5),),
  //            ToggleButtons(
  //              children: <Widget>[
  //                Text(
  //                  "Doctor",
  //                  style: TextStyle(fontSize: 16),
  //                ),
  //                Text(
  //                  "Police",
  //                  style: TextStyle(fontSize: 16),
  //                ),
  //              ],
  //              onPressed: (int index) {
  //                int count = 0;
  //                select2.forEach((bool val) {
  //                  if (val) count++;
  //                });
  //
  //                if (select2[index] && count < 0)
  //                  return;
  //
  //                setState(() {
  //                  select2[index] = !select2[index];
  //                });
  //              },
  //              borderRadius: BorderRadius.circular(10),
  //              isSelected: select2,
  //            ),
  //            Padding(padding: EdgeInsets.fromLTRB(5, 5, 5, 5),),
  //            ToggleButtons(
  //              children: <Widget>[
  //                Text(
  //                  "Nurse",
  //                  style: TextStyle(fontSize: 14),
  //                ),
  //                Text(
  //                  "Teacher",
  //                  style: TextStyle(fontSize: 14),
  //                )
  //              ],
  //              onPressed: (int index) {
  //                int count = 0;
  //                select3.forEach((bool val) {
  //                  if (val) count++;
  //                });
  //
  //                if (select3[index] && count < 0)
  //                  return;
  //
  //                setState(() {
  //                  select3[index] = !select3[index];
  //                });
  //              },
  //              borderRadius: BorderRadius.circular(10),
  //              isSelected: select3,
  //            ),
  //            Padding(padding: EdgeInsets.fromLTRB(5, 5, 5, 5),),
  //            ToggleButtons(
  //              children: <Widget>[
  //                Text(
  //                  "Baby",
  //                  style: TextStyle(fontSize: 14),
  //                ),
  //              ],
  //              onPressed: (int index) {
  //                int count = 0;
  //                select4.forEach((bool val) {
  //                  if (val) count++;
  //                });
  //
  //                if (select4[index] && count < 0)
  //                  return;
  //
  //                setState(() {
  //                  select4[index] = !select4[index];
  //                });
  //              },
  //              borderRadius: BorderRadius.circular(10),
  //              isSelected: select4,
  //            )
        ],
      ));
    }
  }
