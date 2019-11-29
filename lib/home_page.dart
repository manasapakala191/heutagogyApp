import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:heutagogy/data_models.dart';
import 'package:heutagogy/lessons.dart';
import 'lesson_detail.dart';

class HomePage extends StatelessWidget {
  final String data;

  HomePage(this.data);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Nunito'),
      home: _HomePage(data),
    );
  }
}

class _HomePage extends StatefulWidget {
  final String data;

  _HomePage(this.data);

  @override
  _HomePageState createState() => _HomePageState(data);
}

class _HomePageState extends State<_HomePage> {
  String data;

  _HomePageState(this.data);

  Widget optionsBuilder(BuildContext context, int index) {
    if (index == 0) {
      return Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        // child: Center(
        child: Column(
          children: <Widget>[
            Text(
              "Lets Start Learning",
              style: TextStyle(
                fontSize: 25,
                // fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
        // ),
      );
    }
    if (index == 1) {
      return Padding(
          padding: EdgeInsets.all(20),
          child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 3,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.blueAccent, style: BorderStyle.solid, width: 1.0),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: InkWell(
                  splashColor: Color.fromARGB(40, 0, 0, 200),
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => LessonsPage(data)));
                  },
                  child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                        "Lessons",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black87,
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
                        child: Text(
                          "Study lessons and learn from Quizzes",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Nunito',
                          ),
                        ))
                  ]))));
    } else {
      return Padding(
          padding: EdgeInsets.all(20),
          child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 3,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.blueAccent, style: BorderStyle.solid, width: 1.0),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: InkWell(
                  splashColor: Color.fromARGB(40, 0, 0, 200),
                  onTap: () {
//                    Navigator.push(
//                        context, MaterialPageRoute(builder: (context) => LessonsPage(data)));
                  },
                  child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                        "Summative Assesments",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black87,
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
                        child: Text(
                          "Give Tests and score marks",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Nunito',
                          ),
                        ))
                  ]))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Nunito',
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
          itemCount: 3,
          itemBuilder: optionsBuilder,
        ),
      ),
    );
  }
}
