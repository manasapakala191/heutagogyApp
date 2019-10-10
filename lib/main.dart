import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'my_step_progress.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lesson Details',
      home: LessonDetail(),
    );
  }
}

class LessonDetail extends StatefulWidget {
  @override
  LessonDetailState createState() => LessonDetailState();
}

class LessonDetailState extends State<LessonDetail> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Lesson 1: Words',
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.volume_up,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30, 25, 30, 75),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.black, wordSpacing: 1),
                        children: <TextSpan>[
                          TextSpan(text: "A Simple Heading.\n", style: TextStyle(fontSize: 20)),
                          TextSpan(
                              text: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Corporis quod, suscipit possimus q" +
                                  "uas minima nobis saepe, inventore accusantium molestiae eius ad libero repudiandae? Sit, di" +
                                  "Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptates deleniti a ullam suscip" +
                                  "it. Dolore modi voluptas perspiciatis, dolor in quo sint cumque maiores, quia deleniti accu" +
                                  "Lorem ipsum dolor sit, amet consectetur adipisicing elit. Incidunt quibusdam quam porro, co" +
                                  "expedita rerum assumenda exercitationem hic laudanti\n\n"),
                          TextSpan(
                              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Arial'),
                              text: "nsectetur cupiditate, vero nam dolorum "),
                          TextSpan(
                              text: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Numquam iste consectetur sequi! E" +
                                  "plicabo consequatur facilis? Cupiditate unde, iusto ad placeat numquam ipsa ipsum vero odio" +
                                  "Lorem ipsum dolor, sit amet consectetur adipisicing elit. Voluptatem aspernatur officiis fa" +
                                  "cilis, cum similique magnam dolorem dignissimos delectus quaerat rerum. Tempore dolores et " +
                                  "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nobis, aliquam itaque. Labore ear" +
                                  "um pariatur sint dolore ad, nihil quasi laboriosam quod porro tempora aperiam nesciunt, cup\n\n"),
                          TextSpan(
                              text: "Another Heading.\n",
                              style: TextStyle(fontSize: 20, decoration: TextDecoration.underline)),
                          TextSpan(
                            style: TextStyle(color: Colors.blue),
                            text: "st fuga, labore quos soluta ut quidem obcaecati hic voluptatibus commodi doloremque officii" +
                                "Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quo officia beatae, officiis ab, " +
                                "obcaecati dignissimos ipsum unde nihil, at fugiat recusandae. Voluptates provident a perfer" +
                                "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Similique maiores hic quisquam na" +
                                "Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus, reiciendis debitis obca" +
                                "ecati a pariatur provident inventore sit. Placeat tenetur mollitia quaerat nisi ratione min" +
                                "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eveniet, neque alias? Dolores pra" +
                                "esentium provident, aliquam doloribus eligendi iste tempore modi id fuga accusamus. Molesti" +
                                "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Soluta, numquam. Nesciunt illum i" +
                                "usto laborum eum? Dolore eum facere esse corporis quaerat consectetur ex porro ullam accusa" +
                                "Lorem ipsum dolor sit amet consectetur, adipisicing elit. Repudiandae accusamus delectus ex\n\n",
                          ),
                          TextSpan(text: "A Simple Heading.\n", style: TextStyle(fontSize: 20)),
                          TextSpan(
                              style: TextStyle(fontStyle: FontStyle.italic),
                              text: "m nisi sapiente officiis nostrum fugit deleniti mollitia voluptatibus molestiae, vitae volu" +
                                  "Lorem ipsum dolor sit amet consectetur, adipisicing elit. Fugiat sunt minima ab, commodi qu" +
                                  "os incidunt facere quis beatae vitae aspernatur. Laudantium repellat distinctio perspiciati" +
                                  "Lorem ipsum dolor, sit amet consectetur adipisicing elit. Laudantium aspernatur illo alias." +
                                  " Assumenda blanditiis et quibusdam eum dignissimos atque sequi ipsum inventore, vitae dolor" +
                                  "Lorem, ipsum dolor sit amet consectetur adipisicing elit. Harum nulla dolorem aperiam corru" +
                                  "pti expedita sapiente ipsum quo est ipsam repellendus deleniti itaque veniam dignissimos, v" +
                                  "Lorem ipsum dolor sit amet consectetur adipisicing elit. Vero totam cum quo, odio cumque do" +
                                  "lorem itaque maxime, animi, sit quisquam beatae consectetur fugit explicabo neque voluptas!" +
                                  "Lorem ipsum dolor sit amet consectetur adipisicing elit. Deleniti magni eum, quae rem tempo" +
                                  "ribus blanditiis maiores animi autem pariatur! Sunt, animi at inventore dignissimos consequ\n"),
                        ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => App2()));
        },
        highlightElevation: 0,
        splashColor: Colors.white,
//        foregroundColor: Color.fromRGBO(16, 75, 200, 1),
//        backgroundColor: Colors.white,
//        shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(50),
//          side: BorderSide(color: Color.fromRGBO(16, 75, 200, 1)),
//        ),
        label: Text(
          'Start Exam',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        icon: Icon(Icons.arrow_forward),
      ),
    );
  }
}

// -------------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------------

class App2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Lesson 1: Words',
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
            },
            icon: Icon(
              Icons.volume_up,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: 3,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
          itemBuilder: (context, i) {
            if (i == 0) {
              return Padding(
                padding: EdgeInsets.fromLTRB(20, 30, 20, 40),
                child: Text("Lorem ipsum dolor sit amet, consectetur adipisicing elit. Similique maiores hic quisquam na" +
                    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus, reiciendis debitis obca" +
                    "ecati a pariatur provident inventore sit. Placeat tenetur mollitia quaerat nisi ratione min"),
              );
            } else {
              return ExpansionTile(
                initiallyExpanded: true,
                title: Text(
                  "Overview",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                children: <Widget>[
                  Column(
                    children: _buildExpandableTile(lessons, i),
                  ),
                ],
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.assignment_turned_in),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyProgress()));
        },
        highlightElevation: 0,
        splashColor: Colors.white,
      ),
    );
  }
}

_buildExpandableTile(List<Lesson> lesson, int i) {
  return <Widget>[
    Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Text(lesson[i - 1].lessonText),
    ),
    Padding(
      padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
    ),
  ];
}

class Lesson {
  final String lessonTitle;
  final String lessonText;

  Lesson(this.lessonTitle, this.lessonText);
}

List<Lesson> lessons = [
  new Lesson(
      "The last Lesson",
      "st fuga, labore quos soluta ut quidem obcaecati hic voluptatibus commodi doloremque officii" +
          "Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quo officia beatae, officiis ab, " +
          "obcaecati dignissimos ipsum unde nihil, at fugiat recusandae. Voluptates provident a perfer" +
          "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Similique maiores hic quisquam na" +
          "Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus, reiciendis debitis obca" +
          "ecati a pariatur provident inventore sit. Placeat tenetur mollitia quaerat nisi ratione min" +
          "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eveniet, neque alias? Dolores pra" +
          "esentium provident, aliquam doloribus eligendi iste tempore modi id fuga accusamus. Molesti" +
          "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Soluta, numquam. Nesciunt illum i"),
  new Lesson(
      "Something Else",
      "st fuga, labore quos soluta ut quidem obcaecati hic voluptatibus commodi doloremque officii" +
          "Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quo officia beatae, officiis ab, " +
          "obcaecati dignissimos ipsum unde nihil, at fugiat recusandae. Voluptates provident a perfer" +
          "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Similique maiores hic quisquam na" +
          "Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus, reiciendis debitis obca" +
          "ecati a pariatur provident inventore sit. Placeat tenetur mollitia quaerat nisi ratione min" +
          "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eveniet, neque alias? Dolores pra" +
          "esentium provident, aliquam doloribus eligendi iste tempore modi id fuga accusamus. Molesti" +
          "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Soluta, numquam. Nesciunt illum i"),
];
