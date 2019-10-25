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

  _Lessons.withNextPage(this.title, this.description, this.color, this.nextPage);
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
    _Lessons("Lesson 4", "et\'s readL a story, learn something wonderful and answer the questions.",
        Colors.lightBlueAccent),
    _Lessons("Lesson 5", "Let\'s read a story, learn something wonderful and answer the questions.",
        Colors.amber),
  ];

  var top = 0.0;
  int _itemCount = 6;

  Widget lessonsBuilder(BuildContext context, int index) {
    if (index == 0) {
      return Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Center(
          child: Text(
            "Choose any lesson to begin",
            style: TextStyle(
              fontSize: 25,
              // fontWeight: FontWeight.bold
            ),
          ),
        ),
      );
    } else {
      return Lesson(
        this.lessons[index - 1].title,
        this.lessons[index - 1].description,
        this.lessons[index - 1].color,
        () {
          if (index >= 0 && index < this._itemCount) {
            if (index == 1) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LessonDetail()));
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
        fontFamily: 'Montserrat',
      ),
      home: Scaffold( 
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  // backgroundColor: Colors.lightGreenAccent,
                  flexibleSpace: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      top = constraints.biggest.height;
                      return FlexibleSpaceBar(
                        centerTitle: true,
                        title: AnimatedOpacity(
                          duration: Duration(milliseconds: 300),
                          opacity: top <= 140.0 ? 1.0 : 0.0,
                          child: Text(
                            "Welcome",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        background: Image.asset(
                          "assets/images/books.jpg",
                          // "https://d3ui957tjb5bqd.cloudfront.net/uploads/images/3/36/36367.pic.jpg?1463997427",
                          // "https://images.unsplash.com/photo-1455884981818-54cb785db6fc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1890&q=80",
                          // "https://images.unsplash.com/photo-1455884981818-54cb785db6fc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1890&q=80",
                          // "https://images.unsplash.com/photo-1539795845756-4fadad2905ec?ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
                          fit: BoxFit.fill,
                          // alignment: Alignment.topLeft,
                        ),
                      );
                    },
                  )),
            ];
          },
          body: ListView.builder(
            itemCount: this._itemCount,
            itemBuilder: lessonsBuilder,
          ),
        ),
      ),
    );
  }
}

class Lesson extends StatelessWidget {
  final String title;
  final String summary;
  final Color borderColor;
  final Function func;

  Lesson(this.title, this.summary, this.borderColor, this.func);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 30.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: InkWell(
        onTap: func,
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: EdgeInsets.all(20),
          child: Container(
            child: Column(
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Divider(
                  thickness: 1,
                  // color: borderColor,
                ),
                Text(
                  summary,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // Progress(), 
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// class Progress extends StatefulWidget {
//   @override
//   _ProgressState createState() => _ProgressState();
// }

// class _ProgressState extends State<Progress> {

//   int currentStep = 0;

//   List<Step> _mySteps() {
//     return [
//       Step(
//         title: Text(''),
//         content: Text("Puzzle 2 will come here"),
//         isActive: (currentStep >= 0),
//         state: (currentStep == 0) ? StepState.editing : ((currentStep > 0) ? StepState.complete : StepState.indexed),
//       ),
//       Step(
//         title: Text(''),
//         content: Text("Puzzle 2 will come here"),
//         isActive: (currentStep >= 1),
//         state: (currentStep == 1) ? StepState.editing : ((currentStep > 1) ? StepState.complete : StepState.indexed),
//       ),
//       Step(
//         title: Text(''),
//         content: Text("Puzzle 3 will come here"),
//         isActive: (currentStep >= 2),
//         state: (currentStep == 2) ? StepState.editing : ((currentStep > 2) ? StepState.complete : StepState.indexed),
//       ),
//       Step(
//         title: Text(''),
//         content: Text("Puzzle 4 will come here"),
//         isActive: (currentStep >= 3),
//         state: (currentStep == 3) ? StepState.editing : ((currentStep > 3) ? StepState.complete : StepState.indexed),
//       ),
//       Step(
//         title: Text(''),
//         content: Text("Puzzle 5 will come here"),
//         isActive: (currentStep >= 4),
//         state: (currentStep == 4) ? StepState.editing : ((currentStep > 4) ? StepState.complete : StepState.indexed),
//       ),
//       Step(
//         title: Text(''),
//         content: Text("Puzzle 6 will come here"),
//         isActive: (currentStep >= 5),
//         state: (currentStep == 5) ? StepState.editing : ((currentStep > 5) ? StepState.complete : StepState.indexed),
//       ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Stepper(
//         type: StepperType.horizontal,
//         currentStep: this.currentStep,
//         steps: _mySteps(),
//       );
//   }
// }

