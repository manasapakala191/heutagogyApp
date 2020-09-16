import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:heutagogy/data_models.dart';
import 'file:///C:/Users/pvsma/Desktop/heutagogy/Heutagogy/lib/screens/lessons.dart';
import 'package:heutagogy/summative_assesment.dart';


class HomePage extends StatelessWidget {
  final Map courseData;

  HomePage(this.courseData);
  @override
  Widget build(BuildContext context) {
    return _HomePage(courseData);
  }
}


class _HomePage extends StatefulWidget {
  final Map courseData;

  _HomePage(this.courseData);
  @override
  __HomePageState createState() => __HomePageState(courseData);
}

class __HomePageState extends State<_HomePage> {
  Map courseData;
  __HomePageState(courseData);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Let\'s Study"),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          ),
          Padding(
              padding: EdgeInsets.all(20),
              child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.blueAccent,
                        style: BorderStyle.solid,
                        width: 1.0),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: InkWell(
                      splashColor: Color.fromARGB(40, 0, 0, 200),
                      onTap: () {
                        // Navigator.push(
                        //     context, MaterialPageRoute(builder: (context) => LessonsPage(this.data)));
                      },
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
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
                                padding: EdgeInsets.only(
                                    top: 10, left: 20, right: 20, bottom: 20),
                                child: Text(
                                  "Study lessons and learn from quizzes",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Nunito',
                                  ),
                                ))
                          ])))),
          Padding(
              padding: EdgeInsets.all(20),
              child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.blueAccent,
                        style: BorderStyle.solid,
                        width: 1.0),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: InkWell(
                      splashColor: Color.fromARGB(40, 0, 0, 200),
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             SummativeTests(assessment)));
                      },
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Hero(
                                tag: "assessment",
                                child: Material(
                                  color: Colors.transparent,
                                  child: Text(
                                    "Summative Assesments",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.black87,
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 10, left: 20, right: 20, bottom: 20),
                                child: Text(
                                  "Give tests and score marks",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Nunito',
                                  ),
                                ))
                          ])))),
        ],
      ),
    );
  }
}
