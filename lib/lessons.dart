import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'lesson_detail.dart';

class LessonsPage extends StatefulWidget {
  @override
  _LessonsPageState createState() => _LessonsPageState();
}

class _Lessons {
  String title;
  String description;
  Color color;
  Widget nextPage;

  _Lessons(this.title, this.description, this.color);

  _Lessons.withNextPage(
      this.title, this.description, this.color, this.nextPage);
}

class _LessonsPageState extends State<LessonsPage> {
  List<_Lessons> lessons = [
    _Lessons(
      "Lesson 1: Story",
      "Let\'s read a story, learn something wonderful and answer the questions.",
      Colors.orangeAccent,
    ),
    _Lessons(
        "Lesson 2: Grammar",
        "Let\'s learn about Grammer, Sentences, Tenses, Verbs, Words and many more.",
        Colors.greenAccent),
    _Lessons(
        "Lesson 3: Voculabry",
        "Let\' learn some new words and learn about the synonymns and antonyms. ",
        Colors.redAccent),
    _Lessons(
        "Lesson 4",
        "Let\'s readL a story, learn something wonderful and answer the questions.",
        Colors.lightBlueAccent),
    _Lessons(
        "Lesson 5",
        "Let\'s read a story, learn something wonderful and answer the questions.",
        Colors.amber),
  ];

  var top = 0.0;
  int _itemCount = 6;

  Widget lessonsBuilder(BuildContext context, int index) {
    if (index == 0) {
      return Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        // child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.menu,
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: TextField(
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          suffixIcon: Icon(Icons.search),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.filter_list,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "Choose any lesson to begin",
              style: TextStyle(
                fontSize: 25,
                // fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
        // ),
      );
    } else {
      return Lesson(
        title: this.lessons[index - 1].title,
        summary: this.lessons[index - 1].description,
        func: () {
          if (index >= 0 && index < this._itemCount) {
            if (index == 1) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LessonDetail()));
            }
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Nunito',
      ),
      home: Scaffold(
        body: ListView.builder(
          itemCount: this._itemCount,
          itemBuilder: lessonsBuilder,
        ),
      ),
    );
  }
}

class Lesson extends StatefulWidget {
  final String title;
  final String summary;
  final Function func;
  Lesson({Key key, this.title, this.summary, this.func}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LessonState(title, summary, func);
}

class LessonState extends State<Lesson> {
  String title;
  String summary;
  double progress;
  Function func;
  @override
  void initState() {
    super.initState();
    progress = Random().nextDouble();
  }

  LessonState(this.title, this.summary, this.func);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 3,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Colors.blueAccent, style: BorderStyle.solid, width: 1.0),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: InkWell(
          splashColor: Color.fromARGB(40, 0, 0, 200),
          onTap: func,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  title,
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
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Text(
                  summary,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
              ),
            ],
          ),
        ),
      ),
    );
  } 
}
