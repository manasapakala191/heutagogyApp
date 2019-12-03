import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:heutagogy/data_models.dart';
import 'package:heutagogy/lessons.dart';
import 'package:heutagogy/summative_assesment.dart';

class HomePage extends StatelessWidget {
  final String data;
  final String assessment;

  HomePage(this.data, this.assessment);

  @override
  Widget build(BuildContext context) {
    return _HomePage(data, assessment);
  }
}

class _HomePage extends StatefulWidget {
  final String data;
  final String assessment;

  _HomePage(this.data, this.assessment);

  @override
  _HomePageState createState() => _HomePageState(data, assessment);
}

class _HomePageState extends State<_HomePage> {
  String data;
  LessonData assessment;

  _HomePageState(String lessonData, String assess) {
    this.data = lessonData;
    assessment = LessonData.fromJSON(json.decode(assess));
  }

  Widget optionsBuilder(BuildContext context, int index) {
    if (index == 0) {
      return Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        // child: Center(
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
                        context, MaterialPageRoute(builder: (context) => LessonsPage(this.data)));
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SummativeTests(assessment)));
                  },
                  child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Let\'s Study"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: optionsBuilder,
      ),
    );
  }
}
